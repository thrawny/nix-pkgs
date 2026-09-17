{
  lib,
  stdenv,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  pname,
  version,
  packageLockJson,
}:
let
  platforms = {
    x86_64-linux = "linux-x64";
    aarch64-linux = "linux-arm64";
    aarch64-darwin = "darwin-arm64";
  };
  platform =
    platforms.${stdenv.hostPlatform.system}
      or (throw "T3 Code does not publish a native executable for ${stdenv.hostPlatform.system}");
  locked = packageLockJson.packages."node_modules/@t3code/t3-${platform}";
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = locked.resolved;
    hash = locked.integrity;
  };

  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];
  buildInputs = lib.optionals stdenv.isLinux [ stdenv.cc.cc.lib ];
  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/lib/t3code" "$out/bin"
    cp -r . "$out/lib/t3code/"
    chmod +x "$out/lib/t3code/t3"
    ln -s "$out/lib/t3code/t3" "$out/bin/t3"
    runHook postInstall
  '';

  # Nix Linux uses glibc. The npm tarball also bundles musl-only alternatives.
  preFixup = lib.optionalString stdenv.isLinux ''
    find "$out/lib/t3code/node_modules" -type f -name '*.musl.node' -delete
    rm -rf "$out/lib/t3code/node_modules/@ff-labs/fff-bin-linux-"*-musl
  '';

  meta = {
    description = "T3 Code CLI/server";
    homepage = "https://github.com/pingdotgg/t3code";
    license = lib.licenses.mit;
    mainProgram = "t3";
    platforms = builtins.attrNames platforms;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
