#!/usr/bin/env python3
"""Stable-only updater for thrawny-pkgs.

The source of truth is npm's `latest` dist-tag for each package. The script
updates local derivations but never follows moving branches like main.
"""

from __future__ import annotations

import json
import os
import re
import shutil
import subprocess
import sys
import tarfile
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def run(cmd: list[str], *, cwd: Path = ROOT, check: bool = True) -> subprocess.CompletedProcess[str]:
    print(f"$ {' '.join(cmd)}", file=sys.stderr)
    return subprocess.run(cmd, cwd=cwd, check=check, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)


def npm_view(package: str, field: str) -> str:
    result = run(["npm", "view", package, field, "--json"])
    return json.loads(result.stdout)


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
    converted = run(["nix", "hash", "convert", "--hash-algo", "sha256", "--to", "sri", base32])
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
        flags=re.S,
    )
    text = re.sub(
        r'(pnpmDeps = fetchPnpmDeps \{.*?\n\s*hash = )"[^"]+";',
        r'\1lib.fakeHash;',
        text,
        count=1,
        flags=re.S,
    )
    write(package_path, text)

    build = run(["nix", "build", ".#firecrawl-cli", "--no-link"], check=False)
    print(build.stdout, file=sys.stderr)
    match = re.search(r'got:\s+(sha256-[A-Za-z0-9+/=]+)', build.stdout)
    if not match:
        raise RuntimeError("Could not determine firecrawl-cli pnpmDeps hash from nix build output")

    text = read(package_path).replace("hash = lib.fakeHash;", f'hash = "{match.group(1)}";', 1)
    write(package_path, text)
    return True, f"firecrawl-cli: {current} -> {latest}"


def remove_overrides(package_json: dict) -> dict:
    cleaned = dict(package_json)
    cleaned.pop("overrides", None)
    return cleaned


def update_t3code() -> tuple[bool, str | None]:
    package_path = ROOT / "packages/t3code/package.nix"
    package_json_path = ROOT / "packages/t3code/package.json"
    package_lock_path = ROOT / "packages/t3code/package-lock.json"

    current = current_version(package_path)
    latest = npm_view("t3", "dist-tags.latest")

    if current == latest:
        print(f"t3code already up to date ({current})")
        return False, None

    integrity = npm_view(f"t3@{latest}", "dist.integrity")
    print(f"t3code: {current} -> {latest}")

    with tempfile.TemporaryDirectory() as tmpdir_str:
        tmpdir = Path(tmpdir_str)
        pack = run(["npm", "pack", f"t3@{latest}", "--pack-destination", str(tmpdir), "--silent"])
        tarball = tmpdir / pack.stdout.strip().splitlines()[-1]
        extract_dir = tmpdir / "extract"
        extract_dir.mkdir()
        with tarfile.open(tarball, "r:gz") as archive:
            archive.extractall(extract_dir, filter="data")

        upstream_package_json = json.loads((extract_dir / "package/package.json").read_text())
        package_json_path.write_text(json.dumps(upstream_package_json, indent=2) + "\n")

        lock_dir = tmpdir / "lock"
        lock_dir.mkdir()
        (lock_dir / "package.json").write_text(json.dumps(remove_overrides(upstream_package_json), indent=2) + "\n")
        run(["npm", "install", "--package-lock-only", "--ignore-scripts"], cwd=lock_dir)
        shutil.copyfile(lock_dir / "package-lock.json", package_lock_path)

    text = set_version(read(package_path), latest)
    text = re.sub(
        r'(url = "https://registry\.npmjs\.org/t3/-/t3-\$\{finalAttrs\.version\}\.tgz";\n\s*hash = )"[^"]+";',
        rf'\1"{integrity}";',
        text,
        count=1,
    )
    write(package_path, text)
    return True, f"t3code: {current} -> {latest}"


def main() -> int:
    changed: list[str] = []
    for updater in (update_t3code, update_firecrawl_cli):
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

    print(json.dumps({"needs_update": needs_update, "commit_message": commit_message, "changed_packages": changed}, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
