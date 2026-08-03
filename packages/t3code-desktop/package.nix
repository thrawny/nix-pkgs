{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "t3code-desktop";
  version = "0.0.31";

  src = fetchurl {
    url = "https://github.com/pingdotgg/t3code/releases/download/v${version}/T3-Code-${version}-x86_64.AppImage";
    hash = "sha256-AqTkoSKeQwmql3L9F5SbD1XyqeFyqe11ciq9Tp04Zyw=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/t3code.desktop \
      $out/share/applications/t3code.desktop

    mkdir -p $out/share
    cp -r ${appimageContents}/usr/share/icons $out/share/icons

    substituteInPlace $out/share/applications/t3code.desktop \
      --replace-fail 'Name=T3 Code (Alpha)' 'Name=T3 Code' \
      --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=t3code-desktop %U'
  '';

  meta = {
    description = "T3 Code desktop app";
    homepage = "https://github.com/pingdotgg/t3code";
    changelog = "https://github.com/pingdotgg/t3code/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "t3code-desktop";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
