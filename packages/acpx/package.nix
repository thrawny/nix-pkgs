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
  version = "0.12.0";

  nodejs = nodejs_24;

  src = fetchurl {
    url = "https://registry.npmjs.org/acpx/-/acpx-${finalAttrs.version}.tgz";
    hash = "sha512-APYpN04XFWrCGuSBvM4HTKWWFH8uSIuzc+qI7aCGeVdP9o4euZeBosFEkmNUHvBOop0XBemg6d8RsNvzXN3Mgw==";
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
  '';

  postFixup = ''
    wrapProgram "$out/bin/acpx" \
      --run 'if [ -z "''${CODEX_PATH:-}" ]; then codex_path="$(command -v codex || true)"; if [ -n "$codex_path" ]; then export CODEX_PATH="$codex_path"; fi; fi'
  '';

  meta = {
    description = "Headless CLI client for stateful Agent Client Protocol sessions";
    homepage = "https://github.com/openclaw/acpx";
    license = lib.licenses.mit;
    mainProgram = "acpx";
    platforms = lib.platforms.unix;
  };
})
