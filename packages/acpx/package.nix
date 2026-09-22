{
  lib,
  buildNpmPackage,
  fetchurl,
  importNpmLock,
  makeWrapper,
  nodejs_24,
}:

buildNpmPackage (finalAttrs: {
  pname = "acpx";
  version = "0.19.1";

  nodejs = nodejs_24;

  src = fetchurl {
    url = "https://registry.npmjs.org/acpx/-/acpx-${finalAttrs.version}.tgz";
    hash = "sha512-zKVZVM6tHGXmdXU+sC30jdFLzz0ZpNLMorYKH+it3XcuEcvFl20sLbHPqfdjfsLfV+PmhRDEm1b9Np5KxgFHow==";
  };

  npmDeps = importNpmLock {
    package = lib.importJSON ./package.json;
    packageLock = lib.importJSON ./package-lock.json;
  };
  npmConfigHook = importNpmLock.npmConfigHook;

  nativeBuildInputs = [ makeWrapper ];

  # The published npm package already contains dist/.
  dontNpmBuild = true;

  postPatch = ''
    cp ${./package.json} package.json
    cp ${./package-lock.json} package-lock.json

    # Use the adapter selected by package-lock.json rather than acpx's stale
    # built-in range. Fail if upstream moves or duplicates the declaration.
    ${nodejs_24}/bin/node --input-type=module <<'EOF'
    import fs from "node:fs";

    const packageJson = JSON.parse(fs.readFileSync("package.json", "utf8"));
    const adapterRange = packageJson.dependencies["@agentclientprotocol/claude-agent-acp"];
    const declaration = /\bclaude: "\^\d+\.\d+\.\d+"/g;
    const matches = fs
      .readdirSync("dist", { recursive: true })
      .filter((name) => name.endsWith(".js"))
      .flatMap((name) => {
        const bundlePath = `dist/''${name}`;
        const source = fs.readFileSync(bundlePath, "utf8");
        return [...source.matchAll(declaration)].map(() => ({ bundlePath, source }));
      });
    if (matches.length !== 1) {
      throw new Error(`Expected one Claude adapter declaration, found ''${matches.length}`);
    }
    const { bundlePath, source } = matches[0];
    fs.writeFileSync(
      bundlePath,
      source.replace(declaration, `claude: "''${adapterRange}"`),
    );
    EOF
  '';

  postFixup = ''
    wrapProgram "$out/bin/acpx" \
      --run 'if [ -z "''${CODEX_PATH:-}" ]; then codex_path="$(command -v codex || true)"; if [ -n "$codex_path" ]; then export CODEX_PATH="$codex_path"; fi; fi' \
      --run 'if [ -z "''${CLAUDE_CODE_EXECUTABLE:-}" ]; then claude_path="$(command -v claude || true)"; if [ -n "$claude_path" ]; then export CLAUDE_CODE_EXECUTABLE="$claude_path"; fi; fi'
  '';

  meta = {
    description = "Headless CLI client for stateful Agent Client Protocol sessions";
    homepage = "https://github.com/openclaw/acpx";
    license = lib.licenses.mit;
    mainProgram = "acpx";
    platforms = lib.platforms.unix;
  };
})
