import base64
import importlib.util
import io
import json
import subprocess
import tarfile
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

spec = importlib.util.spec_from_file_location(
    "update_packages", Path(__file__).with_name("update-packages.py")
)
updater = importlib.util.module_from_spec(spec)
spec.loader.exec_module(updater)


class T3ReleaseTests(unittest.TestCase):
    version = "0.1.1-nightly.20261016.3203"
    platforms = ("linux-x64", "linux-arm64", "darwin-arm64")

    def checksums(self, platforms=None):
        return "\r\n".join(
            f"{'ab' * 32}  *t3-{self.version}-{platform}.tar.gz"
            for platform in (self.platforms if platforms is None else platforms)
        ).encode()

    def test_release_sources_pin_all_supported_archives(self):
        with patch.object(
            updater.urllib.request, "urlopen", return_value=io.BytesIO(self.checksums())
        ) as request:
            sources = updater.t3code_release_sources(self.version)
        request.assert_called_once_with(
            f"https://github.com/pingdotgg/t3code/releases/download/v{self.version}/SHA256SUMS",
            timeout=60,
        )
        self.assertEqual(set(sources), set(self.platforms))
        for platform, source in sources.items():
            self.assertTrue(
                source["resolved"].endswith(f"/t3-{self.version}-{platform}.tar.gz")
            )
            self.assertEqual(
                source["integrity"],
                "sha256-" + base64.b64encode(bytes.fromhex("ab" * 32)).decode(),
            )

    def test_missing_platform_checksum_rejects_release(self):
        with (
            patch.object(
                updater.urllib.request,
                "urlopen",
                return_value=io.BytesIO(self.checksums(("linux-x64",))),
            ),
            self.assertRaisesRegex(RuntimeError, "Missing T3 release checksum"),
        ):
            updater.t3code_release_sources(self.version)

    def test_updater_repairs_same_version_without_release_sources(self):
        manifest = {
            "name": "t3",
            "version": self.version,
            "bin": {"t3": "./bin/t3.mjs"},
        }
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            package = root / "packages/t3code-nightly"
            package.mkdir(parents=True)
            (package / "package.json").write_text(json.dumps(manifest))
            (package / "package-lock.json").write_text("{}")
            (package / "package.nix").write_text(
                f'  version = "{self.version}";\n'
                '  srcHash = "old";\n'
                "  packageJsonFile = ./package.json;\n"
            )

            def run(cmd, **kwargs):
                if cmd[:2] == ["npm", "pack"]:
                    archive = Path(cmd[cmd.index("--pack-destination") + 1]) / "t3.tgz"
                    content = json.dumps(manifest).encode()
                    with tarfile.open(archive, "w:gz") as tar:
                        info = tarfile.TarInfo("package/package.json")
                        info.size = len(content)
                        tar.addfile(info, io.BytesIO(content))
                    return subprocess.CompletedProcess(cmd, 0, "t3.tgz\n")
                self.assertEqual(cmd[:2], ["npm", "install"])
                (kwargs["cwd"] / "package-lock.json").write_text("{}")
                return subprocess.CompletedProcess(cmd, 0, "")

            with (
                patch.object(updater, "ROOT", root),
                patch.object(updater, "npm_view", side_effect=[self.version, "new"]),
                patch.object(updater, "run", side_effect=run),
                patch.object(
                    updater.urllib.request,
                    "urlopen",
                    return_value=io.BytesIO(self.checksums()),
                ),
            ):
                changed, _ = updater.update_t3code_nightly()
            self.assertTrue(changed)
            self.assertEqual(
                set(json.loads((package / "release-sources.json").read_text())),
                set(self.platforms),
            )
            self.assertIn(
                "releaseSourcesFile = ./release-sources.json;",
                (package / "package.nix").read_text(),
            )
            with (
                patch.object(updater, "ROOT", root),
                patch.object(updater, "npm_view", return_value=self.version),
                patch.object(updater, "run") as run_again,
            ):
                self.assertEqual(updater.update_t3code_nightly(), (False, None))
                run_again.assert_not_called()


class T3DesktopNightlyTests(unittest.TestCase):
    version = "0.1.7-nightly.20261101.4035"

    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        root_patch = patch.object(updater, "ROOT", self.root)
        root_patch.start()
        self.addCleanup(root_patch.stop)
        self.server = self.root / "packages/t3code-nightly/package.nix"
        self.desktop = self.root / "packages/t3code-desktop-nightly/package.nix"
        self.server.parent.mkdir(parents=True)
        self.desktop.parent.mkdir(parents=True)
        self.server.write_text(f'  version = "{self.version}";\n')
        self.desktop.write_text(
            '  version = "old";\n  src = fetchurl {\n    hash = "old-hash";\n  };\n'
        )
        self.asset_name = f"T3-Code-{self.version}-x86_64.AppImage"
        self.asset = {
            "name": self.asset_name,
            "browser_download_url": (
                f"https://github.com/pingdotgg/t3code/releases/download/v{self.version}/"
                f"{self.asset_name}"
            ),
            "digest": "sha256:" + "ab" * 32,
        }

    def release_response(self, assets):
        return io.BytesIO(json.dumps({"assets": assets}).encode())

    def test_desktop_tracks_pinned_server_without_querying_npm(self):
        with (
            patch.object(
                updater.urllib.request,
                "urlopen",
                return_value=self.release_response([self.asset]),
            ) as request,
            patch.object(updater, "npm_view") as npm,
        ):
            changed, message = updater.update_t3code_desktop_nightly()
        self.assertTrue(changed)
        self.assertIn(self.version, message)
        npm.assert_not_called()
        request.assert_called_once_with(
            f"https://api.github.com/repos/pingdotgg/t3code/releases/tags/v{self.version}",
            timeout=60,
        )
        self.assertEqual(updater.current_version(self.desktop), self.version)
        integrity = "sha256-" + base64.b64encode(bytes.fromhex("ab" * 32)).decode()
        self.assertIn(f'hash = "{integrity}";', self.desktop.read_text())
        with patch.object(updater.urllib.request, "urlopen") as request:
            self.assertEqual(updater.update_t3code_desktop_nightly(), (False, None))
            request.assert_not_called()

    def test_missing_or_unverifiable_asset_does_not_change_desktop(self):
        original = self.desktop.read_text()
        for assets in (
            [],
            [self.asset | {"digest": None}],
            [self.asset | {"digest": "sha256:bad"}],
            [self.asset | {"name": "stable.AppImage"}],
            [self.asset | {"browser_download_url": "https://example.com/wrong"}],
            [self.asset, self.asset],
        ):
            with self.subTest(assets=assets):
                with (
                    patch.object(
                        updater.urllib.request,
                        "urlopen",
                        return_value=self.release_response(assets),
                    ),
                    self.assertRaisesRegex(RuntimeError, "Missing T3 desktop"),
                ):
                    updater.update_t3code_desktop_nightly()
                self.assertEqual(self.desktop.read_text(), original)

    def test_main_updates_server_before_desktop(self):
        calls = []
        with (
            patch.object(updater, "update_acpx", return_value=(False, None)),
            patch.object(updater, "update_t3code", return_value=(False, None)),
            patch.object(
                updater,
                "update_t3code_nightly",
                side_effect=lambda: (calls.append("server") or True, "server updated"),
            ),
            patch.object(
                updater,
                "update_t3code_desktop_nightly",
                side_effect=lambda: (
                    calls.append("desktop") or True,
                    "desktop updated",
                ),
            ),
            patch.object(updater, "update_firecrawl_cli", return_value=(False, None)),
            patch.object(updater, "update_portless", return_value=(False, None)),
            patch.dict(updater.os.environ, {}, clear=True),
            patch("sys.stdout", new_callable=io.StringIO),
        ):
            self.assertEqual(updater.main(), 0)
        self.assertEqual(calls, ["server", "desktop"])


if __name__ == "__main__":
    unittest.main()
