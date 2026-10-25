{
  lib,
  stdenv,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  patchelf,
  pname,
  version,
  packageLockJson,
  releaseSources ? null,
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
  locked =
    if releaseSources != null then
      releaseSources.${platform}
    else
      packageLockJson.packages."node_modules/@t3code/t3-${platform}";
  # patchelf 0.19.2 creates overlapping LOAD mappings when it grows this
  # executable's RPATH, making .dynamic read-only and crashing the loader.
  # Pin the known-good patcher even when consumers override our nixpkgs input.
  compatiblePatchelf = patchelf.overrideAttrs {
    version = "0.15.2";
    src = fetchurl {
      url = "https://github.com/NixOS/patchelf/releases/download/0.15.2/patchelf-0.15.2.tar.bz2";
      hash = "sha256-F3RfVkFZyOIo/EEtplogSLhGxLa0Igt3y/IkFuAvLXw=";
    };
    patches = [ ];
  };
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = locked.resolved;
    hash = locked.integrity;
  };

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    compatiblePatchelf
    autoPatchelfHook
  ];
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [ stdenv.cc.cc.lib ];
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
  preFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    find "$out/lib/t3code/node_modules" -type f -name '*.musl.node' -delete
    rm -rf "$out/lib/t3code/node_modules/@ff-labs/fff-bin-linux-"*-musl
  '';

  # Run the installed, fully patched executable, not just a build-time tool.
  doInstallCheck = stdenv.buildPlatform.canExecute stdenv.hostPlatform;
  installCheckPhase = ''
    runHook preInstallCheck
    "$out/bin/t3" --version
    runHook postInstallCheck
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
