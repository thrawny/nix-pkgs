{
  lib,
  stdenvNoCC,
  fetchurl,
  makeWrapper,
  nodejs_24,
  openssl,
  lsof,
  procps,
  tailscaleCommand ? "tailscale",
  proxyPortCommand ? null,
  extraEnvironment ? { },
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "portless";
  version = "0.15.12";

  # Published JavaScript bundles all runtime dependencies. No npm installation
  # or lifecycle scripts are needed.
  src = fetchurl {
    url = "https://registry.npmjs.org/portless/-/portless-${finalAttrs.version}.tgz";
    hash = "sha512-Lbz85zLboOMkvq2unXYfJ/YMpsvFZYQgrwGEbinZErp045y9fLm4obm7E77V2BI2Om0Mh6tX/2w2ftFqRs5kfQ==";
  };

  nativeBuildInputs = [ makeWrapper ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/lib/portless" "$out/bin"
    cp -r dist package.json "$out/lib/portless/"
    # A restricted adapter can replace the CLI on multi-user hosts without
    # granting every account full Tailscale operator privileges.
    substituteInPlace "$out/lib/portless/dist/cli.js" \
      --replace-fail 'var TAILSCALE_BINARY = "tailscale";' 'var TAILSCALE_BINARY = ${builtins.toJSON tailscaleCommand};' \
      --replace-fail 'const maxAttempts = 3;' 'const maxAttempts = 32;'
    makeWrapper ${lib.getExe nodejs_24} "$out/bin/portless" \
      --add-flags "$out/lib/portless/dist/cli.js" \
      --prefix PATH : ${
        lib.makeBinPath (
          [
            openssl
            lsof
          ]
          ++ lib.optional stdenvNoCC.hostPlatform.isLinux procps
        )
      } \
      ${
        lib.concatStringsSep " \\\n      " (
          lib.mapAttrsToList (
            name: value: "--set-default ${lib.escapeShellArg name} ${lib.escapeShellArg value}"
          ) extraEnvironment
        )
      } \
      ${lib.optionalString (proxyPortCommand != null)
        "--run ${lib.escapeShellArg ''export PORTLESS_PORT="''${PORTLESS_PORT:-$(${proxyPortCommand})}"''}"
      }
    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    export HOME="$TMPDIR/portless-home"
    export PORTLESS_PORT=21355 PORTLESS_TAILSCALE=0 PORTLESS_HTTPS=0 PORTLESS_SYNC_HOSTS=0
    mkdir -p "$HOME"
    "$out/bin/portless" --version | grep -Fx '${finalAttrs.version}'
    "$out/bin/portless" --help | grep -F -- '--tailscale'
    runHook postInstallCheck
  '';

  meta = {
    description = "Stable, named development URLs for humans and coding agents";
    homepage = "https://github.com/vercel-labs/portless";
    license = lib.licenses.asl20;
    mainProgram = "portless";
    platforms = lib.platforms.unix;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
  };
})
