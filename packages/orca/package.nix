{
  lib,
  stdenv,
  appimageTools,
  fetchurl,
}:

let
  pname = "orca";
  version = "1.4.169";

  platform =
    {
      x86_64-linux = {
        asset = "orca-linux.AppImage";
        hash = "sha256-EEPIenkLunHGbko79BhoU29SWghwMW8AT9Wt7TH7Z1o=";
      };
      aarch64-linux = {
        asset = "orca-linux-arm64.AppImage";
        hash = "sha256-XIFq08e4KoymFaw7P3IznrRODUn2mVx/nyc+GnbS/zg=";
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
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/orca-ide.desktop \
      $out/share/applications/orca.desktop

    mkdir -p $out/share
    cp -r ${appimageContents}/usr/share/icons $out/share/icons

    substituteInPlace $out/share/applications/orca.desktop \
      --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=orca %U'
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
