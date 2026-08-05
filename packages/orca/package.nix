{
  lib,
  stdenv,
  appimageTools,
  dejavu_fonts,
  fetchurl,
  fontconfig,
  makeFontsConf,
  makeWrapper,
  noto-fonts,
  noto-fonts-color-emoji,
  runCommand,
}:

let
  pname = "orca";
  version = "1.4.170";

  platform =
    {
      x86_64-linux = {
        asset = "orca-linux.AppImage";
        hash = "sha256-7iIaZpuQAO5E1XCb3GnNiwS5RYKG6WNB6mcNykZrot0=";
      };
      aarch64-linux = {
        asset = "orca-linux-arm64.AppImage";
        hash = "sha256-/wZ+aDov/ftWldFCMNx3Zj+dZR8rhLPKDy8XB8b6rn8=";
      };
    }
    .${stdenv.hostPlatform.system};

  src = fetchurl {
    url = "https://github.com/stablyai/orca/releases/download/v${version}/${platform.asset}";
    inherit (platform) hash;
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

  fontsConfBase = makeFontsConf {
    fontDirectories = [
      dejavu_fonts
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
  fontsConf = runCommand "fonts.conf" { } ''
    substitute ${fontsConfBase} "$out" \
      --replace-fail \
        '<include ignore_missing="yes">/etc/fonts/conf.d</include>' \
        '<include ignore_missing="yes">${fontconfig.out}/etc/fonts/conf.d</include>'
  '';
in
appimageTools.wrapType2 {
  inherit pname version src;

  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/orca-ide.desktop \
      $out/share/applications/orca.desktop

    mkdir -p $out/share
    cp -r ${appimageContents}/usr/share/icons $out/share/icons

    substituteInPlace $out/share/applications/orca.desktop \
      --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=orca %U'

    wrapProgram $out/bin/orca \
      --set FONTCONFIG_FILE ${lib.escapeShellArg fontsConf}
  '';

  meta = {
    description = "ADE for working with a fleet of parallel coding agents";
    homepage = "https://github.com/stablyai/orca";
    changelog = "https://github.com/stablyai/orca/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "orca";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
