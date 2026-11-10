default:
    just --list

fmt:
    nix fmt

check:
    nix flake check

check-workflows:
    actionlint .github/workflows/*.yml

build package:
    nix build .#{{package}}

# Build and run both T3 channels against a consumer's nixpkgs revision.
check-t3code nixpkgs="":
    #!/usr/bin/env bash
    set -euo pipefail
    nix_args=()
    if [[ -n {{quote(nixpkgs)}} ]]; then
        nix_args+=(--override-input nixpkgs {{quote(nixpkgs)}} --no-write-lock-file)
    fi
    nix build "${nix_args[@]}" .#t3code .#t3code-nightly --no-link --print-out-paths
    nix run "${nix_args[@]}" .#t3code -- --version
    nix run "${nix_args[@]}" .#t3code-nightly -- --version

check-updater:
    python3 -m unittest discover -s scripts -p 'test_*.py'

# Run outside the Nix build sandbox: bubblewrap needs user namespaces.
check-t3code-desktop:
    #!/usr/bin/env bash
    set -euo pipefail
    desktop=$(nix build .#t3code-desktop-nightly --no-link --print-out-paths)
    nix shell --inputs-from . nixpkgs#python3 nixpkgs#xvfb-run -c python3 scripts/smoke_t3code_desktop.py "$desktop"

# Validate the Linux desktop and core, optionally checking personal mods.
check-herdr config="" nixpkgs="":
    #!/usr/bin/env bash
    set -euo pipefail
    nix_args=()
    if [[ -n {{quote(nixpkgs)}} ]]; then
        nix_args+=(--override-input nixpkgs {{quote(nixpkgs)}} --no-write-lock-file)
    fi
    app=$(nix build "${nix_args[@]}" .#herdr-app --no-link --print-out-paths)
    core=$(nix build "${nix_args[@]}" .#herdr-core --no-link --print-out-paths)
    "$app/bin/herdr-app" --version
    "$core/bin/herdr-core" --version
    if [[ -n {{quote(config)}} ]]; then
        for mod in {{quote(config)}}/mods/thrawny-*; do
            "$app/bin/herdr-app" check "$mod"
        done
    fi

update:
    nix develop -c scripts/update-packages.py
