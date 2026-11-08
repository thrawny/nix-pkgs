{
  lib,
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
  pname = "t3code-desktop-nightly";
  version = "0.1.8-nightly.20261108.4367";

  src = fetchurl {
    url = "https://github.com/pingdotgg/t3code/releases/download/v${version}/T3-Code-${version}-x86_64.AppImage";
    hash = "sha256-GyEGcOfU7CrtJHvzBKpsbzhx6vaCA8w3izteBPdsPQE=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };

  # The FHS environment needs a store-backed font configuration, not the
  # host's /etc/fonts paths (which may not exist inside the namespace).
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
    install -m 444 -D ${appimageContents}/t3code.desktop \
      $out/share/applications/t3code-desktop-nightly.desktop

    # Do not collide with the stable desktop's launcher or icons.
    for icon in ${appimageContents}/usr/share/icons/hicolor/*/apps/t3code.png; do
      size=$(basename "$(dirname "$(dirname "$icon")")")
      install -m 444 -D "$icon" \
        "$out/share/icons/hicolor/$size/apps/t3code-desktop-nightly.png"
    done
    substituteInPlace $out/share/applications/t3code-desktop-nightly.desktop \
      --replace-fail 'Exec=AppRun %U' 'Exec=t3code-desktop-nightly %U' \
      --replace-fail 'Icon=t3code' 'Icon=t3code-desktop-nightly'

    wrapProgram $out/bin/t3code-desktop-nightly \
      --set FONTCONFIG_FILE ${lib.escapeShellArg fontsConf} \
      --set T3CODE_DISABLE_AUTO_UPDATE 1 \
      --set T3CODE_DESKTOP_LAUNCHER_PATH "$out/bin/t3code-desktop-nightly" \
      --unset APPIMAGE
  '';

  meta = {
    description = "T3 Code nightly desktop app";
    homepage = "https://github.com/pingdotgg/t3code";
    changelog = "https://github.com/pingdotgg/t3code/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "t3code-desktop-nightly";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
