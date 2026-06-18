# thrawny-pkgs

Personal Nix package set for small or finicky packages that do not belong in dotfiles.

## Packages

- `t3code` / `t3` - T3 Code CLI/server from the published npm artifact.
- `firecrawl-cli` - Firecrawl CLI built from upstream source with pnpm.

## Usage

```bash
nix build .#t3code
nix run .#firecrawl-cli -- --help
```
