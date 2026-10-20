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
  version = "1.26.15";

  src = fetchFromGitHub {
    owner = "firecrawl";
    repo = "cli";
    rev = "v${finalAttrs.version}";
    hash = "sha256-oyTpaH4jhCEdyFmsGo5A5bDHF0eP87Shg1krH87HDns=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 4;
    hash = "sha256-63iFBMby1a+MeeeIyRNtkfyXxvfieKxsCsEjvgE24N8=";
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
