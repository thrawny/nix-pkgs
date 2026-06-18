default:
    just --list

fmt:
    nix fmt

check:
    nix flake check

build package:
    nix build .#{{package}}

update:
    nix develop -c scripts/update-packages.py
