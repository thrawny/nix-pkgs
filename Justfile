default:
    just --list

fmt:
    nix fmt

check:
    nix flake check

build package:
    nix build .#{{package}}
