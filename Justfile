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

update:
    nix develop -c scripts/update-packages.py
