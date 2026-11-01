#!/usr/bin/env python3
"""Smoke-test the installed desktop under Xvfb, without using the user's profile.

Run with python3 and xvfb-run on PATH; pass the desktop package's store path.
FHS/bubblewrap execution requires unprivileged user namespaces (outside the
Nix build sandbox). No agent credentials or graphical login are required.
"""

from __future__ import annotations

import os
import signal
import subprocess
import sys
import tempfile
import time
from pathlib import Path


def main() -> None:
    package = Path(sys.argv[1]).resolve()
    executable = package / "bin/t3code-desktop-nightly"
    desktop = package / "share/applications/t3code-desktop-nightly.desktop"
    assert "Exec=t3code-desktop-nightly %U" in desktop.read_text()
    assert list(
        (package / "share/icons/hicolor").glob("*/apps/t3code-desktop-nightly.png")
    )

    with tempfile.TemporaryDirectory(prefix="t3code-desktop-smoke-") as temporary:
        root = Path(temporary)
        runtime = root / "runtime"
        runtime.mkdir(mode=0o700)
        env = dict(os.environ)
        env.update(
            HOME=str(root),
            XDG_CONFIG_HOME=str(root / "config"),
            XDG_CACHE_HOME=str(root / "cache"),
            XDG_DATA_HOME=str(root / "data"),
            XDG_STATE_HOME=str(root / "state"),
            XDG_RUNTIME_DIR=str(runtime),
            XDG_CURRENT_DESKTOP="",
            XDG_SESSION_DESKTOP="",
            DBUS_SESSION_BUS_ADDRESS="unix:path=/nonexistent",
            T3CODE_HOME=str(root / "t3"),
        )
        env.pop("WAYLAND_DISPLAY", None)
        env.pop("ELECTRON_RUN_AS_NODE", None)
        # Exercise the bundled Node runtime and native modules, including an
        # actual PTY spawn, not merely Electron's --version switch.
        subprocess.run(
            [
                str(executable),
                "-e",
                r"""
const path = require('path');
const root = path.join(path.dirname(process.execPath), 'resources/app.asar');
console.log('T3 Code desktop ' + require(root + '/package.json').version);
if (process.env.T3CODE_DISABLE_AUTO_UPDATE !== '1') throw Error('self-updater enabled');
require(root + '/node_modules/@ff-labs/fff-node');
require(root + '/node_modules/@napi-rs/keyring');
const pty = require(root + '/node_modules/node-pty').spawn(
  '/bin/sh', ['-c', 'printf pty-ok'], {env: process.env});
let output = '';
pty.onData(data => { output += data; });
pty.onExit(({exitCode}) => {
  if (exitCode !== 0 || output !== 'pty-ok') process.exit(1);
  console.log('Native modules and PTY OK');
});
""",
            ],
            env=env | {"ELECTRON_RUN_AS_NODE": "1"},
            check=True,
            timeout=30,
        )
        with (root / "startup.log").open("w+") as log:
            process = subprocess.Popen(
                [
                    "xvfb-run",
                    "-a",
                    str(executable),
                    "--disable-gpu",
                    "--ozone-platform=x11",
                ],
                env=env,
                stdout=log,
                stderr=subprocess.STDOUT,
                start_new_session=True,
            )
            try:
                deadline = time.monotonic() + 60
                while time.monotonic() < deadline:
                    log.seek(0)
                    output = log.read()
                    if process.poll() is not None:
                        raise RuntimeError(
                            f"Desktop exited early ({process.returncode})"
                        )
                    if "backend ready" in output and "main window created" in output:
                        if "Fontconfig error" in output:
                            raise RuntimeError("Broken desktop font configuration")
                        print(
                            "Desktop backend ready and main window created under Xvfb"
                        )
                        break
                    time.sleep(0.25)
                else:
                    raise RuntimeError("Desktop did not become ready within 60 seconds")
            except BaseException:
                log.seek(0)
                print(log.read(), file=sys.stderr)
                raise
            finally:
                # Include Electron's backend and renderer children, not just
                # the xvfb-run wrapper. Always clean up, including on failure.
                try:
                    os.killpg(process.pid, signal.SIGTERM)
                except ProcessLookupError:
                    pass
                try:
                    process.wait(timeout=10)
                except subprocess.TimeoutExpired:
                    os.killpg(process.pid, signal.SIGKILL)
                    process.wait()


if __name__ == "__main__":
    main()
