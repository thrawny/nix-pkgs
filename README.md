# thrawny-pkgs

Personal Nix package set for small or finicky packages that do not belong in dotfiles.

## Packages

- `acpx` - Headless ACP client with a compatible Claude adapter, wrapped to use the Codex and Claude Code CLIs found on `PATH` by default.
- `t3code` / `t3` - Stable T3 Code CLI/server from the published npm artifact.
- `t3code-nightly` / `t3-nightly` - T3 Code CLI/server following npm's `nightly` tag.
- `t3code-desktop` - Pinned stable T3 Code desktop app (Linux x86_64).
- `t3code-desktop-nightly` - T3 Code desktop AppImage matching our nightly CLI/server release (Linux x86_64), with a separate launcher and icon. Updates are managed by Nix, not the app's self-updater.
- `firecrawl-cli` - Firecrawl CLI built from upstream source with pnpm.
- `posthog-cli` - PostHog CLI from the official release binaries.
- `portless` - Named development URLs with optional Tailscale sharing, using Node 24.

## Usage

```bash
nix build .#t3code
nix run .#t3code-nightly -- --version
nix run .#t3code-desktop-nightly
nix run .#firecrawl-cli -- --help
nix run .#posthog-cli -- --help
```

The nightly desktop and CLI/server can be installed together; the desktop package
only exports `t3code-desktop-nightly`, leaving `t3` to the CLI/server package.
Desktop execution uses an FHS environment and requires unprivileged user namespaces.
