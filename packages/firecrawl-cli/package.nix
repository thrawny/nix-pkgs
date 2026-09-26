{
  lib,
  fetchFromGitHub,
  fetchPnpmDeps,
  makeWrapper,
  nodejs-slim,
  pnpm_10,
  pnpmConfigHook,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "firecrawl-cli";
  version = "1.24.6";

  src = fetchFromGitHub {
    owner = "firecrawl";
    repo = "cli";
    rev = "v${finalAttrs.version}";
    hash = "sha256-5CULHaMxRq1HCZo37z8CGfkBQ5oQG/6fF77zQM8xv+E=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 4;
    hash = "sha256-wW2qFBRTICSwd6J9K00Tn/66Ji2TQoQVHhEr9jsE7hA=";
  };

  nativeBuildInputs = [
    makeWrapper
    nodejs-slim
    pnpm_10
    pnpmConfigHook
  ];

  buildPhase = ''
    runHook preBuild
    pnpm build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -d "$out/lib/firecrawl-cli" "$out/bin"
    cp -r dist package.json node_modules "$out/lib/firecrawl-cli/"
    makeWrapper ${lib.getExe nodejs-slim} "$out/bin/firecrawl" \
      --add-flags "$out/lib/firecrawl-cli/dist/index.js"

    runHook postInstall
  '';

  meta = {
    description = "Command-line interface for Firecrawl";
    homepage = "https://github.com/firecrawl/cli";
    license = lib.licenses.isc;
    mainProgram = "firecrawl";
    platforms = lib.platforms.unix;
  };
})
