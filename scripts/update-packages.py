#!/usr/bin/env python3
"""Package updater for thrawny-pkgs.

The script follows stable releases except for packages that explicitly expose a
nightly output. It updates local derivations but never follows moving branches
like main.
"""

from __future__ import annotations

import base64
import json
import os
import re
import shutil
import subprocess
import sys
import tarfile
import tempfile
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def run(
    cmd: list[str], *, cwd: Path = ROOT, check: bool = True
) -> subprocess.CompletedProcess[str]:
    print(f"$ {' '.join(cmd)}", file=sys.stderr)
    return subprocess.run(
        cmd,
        cwd=cwd,
        check=check,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )


def npm_view(package: str, field: str) -> str:
    result = run(["npm", "view", package, field, "--json"])
    return json.loads(result.stdout)


def github_latest_release(owner: str, repo: str) -> dict:
    request = urllib.request.Request(
        f"https://api.github.com/repos/{owner}/{repo}/releases/latest",
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "thrawny-pkgs-updater",
            "X-GitHub-Api-Version": "2022-11-28",
        },
    )
    with urllib.request.urlopen(request) as response:
        return json.load(response)


def sri_from_github_digest(digest: str) -> str:
    algorithm, hex_digest = digest.split(":", maxsplit=1)
    if algorithm != "sha256":
        raise RuntimeError(f"Unsupported GitHub asset digest: {algorithm}")
    encoded = base64.b64encode(bytes.fromhex(hex_digest)).decode()
    return f"sha256-{encoded}"


def read(path: Path) -> str:
    return path.read_text()


def write(path: Path, text: str) -> None:
    path.write_text(text)


def current_version(path: Path) -> str:
    match = re.search(r'\bversion = "([^"]+)";', read(path))
    if not match:
        raise RuntimeError(f"Could not find version in {path}")
    return match.group(1)


def set_version(text: str, version: str) -> str:
    return re.sub(r'\bversion = "[^"]+";', f'version = "{version}";', text, count=1)


def prefetch_github_tag(owner: str, repo: str, tag: str) -> str:
    url = f"https://github.com/{owner}/{repo}/archive/refs/tags/{tag}.tar.gz"
    result = run(["nix-prefetch-url", "--unpack", url])
    base32 = result.stdout.strip().splitlines()[-1]
    converted = run(
        ["nix", "hash", "convert", "--hash-algo", "sha256", "--to", "sri", base32]
    )
    return converted.stdout.strip()


def update_firecrawl_cli() -> tuple[bool, str | None]:
    package_path = ROOT / "packages/firecrawl-cli/package.nix"
    current = current_version(package_path)
    latest = npm_view("firecrawl-cli", "dist-tags.latest")

    if current == latest:
        print(f"firecrawl-cli already up to date ({current})")
        return False, None

    print(f"firecrawl-cli: {current} -> {latest}")
    text = set_version(read(package_path), latest)

    src_hash = prefetch_github_tag("firecrawl", "cli", f"v{latest}")
    text = re.sub(
        r'(src = fetchFromGitHub \{.*?\n\s*hash = )"[^"]+";',
        rf'\1"{src_hash}";',
        text,
        count=1,
        flags=re.DOTALL,
    )
    text = re.sub(
        r'(pnpmDeps = fetchPnpmDeps \{.*?\n\s*hash = )"[^"]+";',
        r"\1lib.fakeHash;",
        text,
        count=1,
        flags=re.DOTALL,
    )
    write(package_path, text)

    build = run(["nix", "build", ".#firecrawl-cli", "--no-link"], check=False)
    print(build.stdout, file=sys.stderr)
    match = re.search(r"got:\s+(sha256-[A-Za-z0-9+/=]+)", build.stdout)
    if not match:
        raise RuntimeError(
            "Could not determine firecrawl-cli pnpmDeps hash from nix build output"
        )

    text = read(package_path).replace(
        "hash = lib.fakeHash;", f'hash = "{match.group(1)}";', 1
    )
    write(package_path, text)
    return True, f"firecrawl-cli: {current} -> {latest}"


def update_orca() -> tuple[bool, str | None]:
    package_path = ROOT / "packages/orca/package.nix"
    current = current_version(package_path)
    release = github_latest_release("stablyai", "orca")
    latest = release["tag_name"].removeprefix("v")

    if current == latest:
        print(f"orca already up to date ({current})")
        return False, None

    print(f"orca: {current} -> {latest}")
    asset_digests = {asset["name"]: asset.get("digest") for asset in release["assets"]}
    wanted_assets = ("orca-linux.AppImage", "orca-linux-arm64.AppImage")
    missing = [asset for asset in wanted_assets if not asset_digests.get(asset)]
    if missing:
        raise RuntimeError(
            f"Release v{latest} is missing asset digests for: {', '.join(missing)}"
        )

    text = set_version(read(package_path), latest)
    for asset in wanted_assets:
        sri_hash = sri_from_github_digest(asset_digests[asset])
        text, replacements = re.subn(
            rf'(asset = "{re.escape(asset)}";\n\s*hash = )"[^"]+";',
            rf'\1"{sri_hash}";',
            text,
            count=1,
        )
        if replacements != 1:
            raise RuntimeError(f"Could not update hash for {asset}")

    write(package_path, text)
    return True, f"orca: {current} -> {latest}"


def remove_overrides(package_json: dict) -> dict:
    cleaned = dict(package_json)
    cleaned.pop("overrides", None)
    return cleaned


def semver_tuple(version: str) -> tuple[int, int, int]:
    match = re.fullmatch(r"(\d+)\.(\d+)\.(\d+)", version)
    if not match:
        raise RuntimeError(f"Unsupported semver: {version}")
    return tuple(map(int, match.groups()))


def update_acpx() -> tuple[bool, str | None]:
    package_root = ROOT / "packages/acpx"
    package_path = package_root / "package.nix"
    package_json_path = package_root / "package.json"
    package_lock_path = package_root / "package-lock.json"

    current = current_version(package_path)
    latest = npm_view("acpx", "dist-tags.latest")
    latest_adapter = npm_view(
        "@agentclientprotocol/claude-agent-acp", "dist-tags.latest"
    )
    current_adapter = None
    if package_json_path.exists():
        current_package_json = json.loads(package_json_path.read_text())
        current_adapter_range = current_package_json.get("dependencies", {}).get(
            "@agentclientprotocol/claude-agent-acp"
        )
        if current_adapter_range:
            current_adapter = current_adapter_range.removeprefix("^")

    if (
        current == latest
        and current_adapter == latest_adapter
        and package_lock_path.exists()
    ):
        print(f"acpx already up to date ({current}, Claude adapter {current_adapter})")
        return False, None

    integrity = npm_view(f"acpx@{latest}", "dist.integrity")
    print(
        f"acpx: {current} -> {latest}; "
        f"Claude adapter: {current_adapter or 'missing'} -> {latest_adapter}"
    )

    with tempfile.TemporaryDirectory() as tmpdir_str:
        tmpdir = Path(tmpdir_str)
        pack = run(
            [
                "npm",
                "pack",
                f"acpx@{latest}",
                "--pack-destination",
                str(tmpdir),
                "--silent",
            ]
        )
        tarball = tmpdir / pack.stdout.strip().splitlines()[-1]
        extract_dir = tmpdir / "extract"
        extract_dir.mkdir()
        with tarfile.open(tarball, "r:gz") as archive:
            archive.extractall(extract_dir, filter="data")

        extracted_package = extract_dir / "package"
        live_checkpoints = list(
            (extracted_package / "dist").glob("live-checkpoint-*.js")
        )
        if len(live_checkpoints) != 1:
            raise RuntimeError(
                f"Expected one acpx live-checkpoint bundle, found {len(live_checkpoints)}"
            )
        adapter_match = re.search(
            r'\bclaude: "\^(\d+\.\d+\.\d+)"', live_checkpoints[0].read_text()
        )
        if not adapter_match:
            raise RuntimeError("Could not find the bundled Claude adapter range")
        upstream_adapter_version = adapter_match.group(1)
        adapter_version = max(
            upstream_adapter_version,
            latest_adapter,
            key=semver_tuple,
        )

        package_json = json.loads((extracted_package / "package.json").read_text())
        package_json.pop("scripts", None)
        package_json.pop("devDependencies", None)
        package_json = remove_overrides(package_json)
        package_json["dependencies"]["@agentclientprotocol/claude-agent-acp"] = (
            f"^{adapter_version}"
        )
        package_json["dependencies"] = dict(
            sorted(package_json["dependencies"].items())
        )
        package_json_path.write_text(
            json.dumps(package_json, indent=2, ensure_ascii=False) + "\n"
        )

        lock_dir = tmpdir / "lock"
        lock_dir.mkdir()
        (lock_dir / "package.json").write_text(
            json.dumps(package_json, indent=2, ensure_ascii=False) + "\n"
        )
        run(
            [
                "npm",
                "install",
                "--package-lock-only",
                "--ignore-scripts",
                "--no-audit",
                "--no-fund",
            ],
            cwd=lock_dir,
        )
        shutil.copyfile(lock_dir / "package-lock.json", package_lock_path)

    text = set_version(read(package_path), latest)
    text, replacements = re.subn(
        r'(src = fetchurl \{.*?\n\s*hash = )"[^"]+";',
        rf'\1"{integrity}";',
        text,
        count=1,
        flags=re.DOTALL,
    )
    if replacements != 1:
        raise RuntimeError("Could not update acpx source hash")
    write(package_path, text)

    changes = []
    if current != latest:
        changes.append(f"{current} -> {latest}")
    if current_adapter != adapter_version:
        changes.append(
            f"Claude adapter {current_adapter or 'missing'} -> {adapter_version}"
        )
    return True, f"acpx: {', '.join(changes)}"


def update_t3code_channel(
    name: str, dist_tag: str, package_dir: str
) -> tuple[bool, str | None]:
    package_root = ROOT / f"packages/{package_dir}"
    package_path = package_root / "package.nix"
    package_json_path = package_root / "package.json"
    package_lock_path = package_root / "package-lock.json"

    current = current_version(package_path)
    latest = npm_view("t3", f"dist-tags.{dist_tag}")

    if current == latest and package_json_path.exists() and package_lock_path.exists():
        print(f"{name} already up to date ({current})")
        return False, None

    integrity = npm_view(f"t3@{latest}", "dist.integrity")
    print(f"{name}: {current} -> {latest}")

    with tempfile.TemporaryDirectory() as tmpdir_str:
        tmpdir = Path(tmpdir_str)
        pack = run(
            [
                "npm",
                "pack",
                f"t3@{latest}",
                "--pack-destination",
                str(tmpdir),
                "--silent",
            ]
        )
        tarball = tmpdir / pack.stdout.strip().splitlines()[-1]
        extract_dir = tmpdir / "extract"
        extract_dir.mkdir()
        with tarfile.open(tarball, "r:gz") as archive:
            archive.extractall(extract_dir, filter="data")

        upstream_package_json = json.loads(
            (extract_dir / "package/package.json").read_text()
        )
        package_json_path.write_text(json.dumps(upstream_package_json, indent=2) + "\n")

        lock_dir = tmpdir / "lock"
        lock_dir.mkdir()
        (lock_dir / "package.json").write_text(
            json.dumps(remove_overrides(upstream_package_json), indent=2) + "\n"
        )
        run(["npm", "install", "--package-lock-only", "--ignore-scripts"], cwd=lock_dir)
        shutil.copyfile(lock_dir / "package-lock.json", package_lock_path)

    text = set_version(read(package_path), latest)
    text, replacements = re.subn(
        r'\bsrcHash = "[^"]+";',
        f'srcHash = "{integrity}";',
        text,
        count=1,
    )
    if replacements != 1:
        raise RuntimeError(f"Could not update source hash for {name}")
    write(package_path, text)
    return True, f"{name}: {current} -> {latest}"


def update_t3code() -> tuple[bool, str | None]:
    return update_t3code_channel("t3code", "latest", "t3code")


def update_t3code_nightly() -> tuple[bool, str | None]:
    return update_t3code_channel("t3code-nightly", "nightly", "t3code-nightly")


def main() -> int:
    changed: list[str] = []
    for updater in (
        update_acpx,
        update_t3code,
        update_t3code_nightly,
        update_firecrawl_cli,
        update_orca,
    ):
        did_change, message = updater()
        if did_change and message:
            changed.append(message)

    if len(changed) == 0:
        needs_update = "false"
        commit_message = "packages: no updates"
    elif len(changed) == 1:
        needs_update = "true"
        commit_message = changed[0]
    else:
        needs_update = "true"
        commit_message = "packages: update stable releases"

    output = os.environ.get("GITHUB_OUTPUT")
    if output:
        with open(output, "a", encoding="utf-8") as handle:
            handle.write(f"needs_update={needs_update}\n")
            handle.write(f"commit_message={commit_message}\n")
            handle.write("changed_packages<<EOF\n")
            handle.write("\n".join(changed))
            handle.write("\nEOF\n")

    print(
        json.dumps(
            {
                "needs_update": needs_update,
                "commit_message": commit_message,
                "changed_packages": changed,
            },
            indent=2,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
