# thrawny-pkgs

Personal Nix package set for small or finicky packages that do not belong in dotfiles.

## Packages

- `acpx` - Headless ACP client, wrapped to use the Codex CLI found on `PATH` by default.
- `t3code` / `t3` - Stable T3 Code CLI/server from the published npm artifact.
- `t3code-nightly` / `t3-nightly` - T3 Code CLI/server following npm's `nightly` tag.
- `firecrawl-cli` - Firecrawl CLI built from upstream source with pnpm.
- `posthog-cli` - PostHog CLI from the official release binaries.
- `orca` - Orca desktop ADE, wrapped from the official Linux AppImage.

## Usage

```bash
nix build .#t3code
nix run .#t3code-nightly -- --version
nix run .#firecrawl-cli -- --help
nix run .#posthog-cli -- --help
```
