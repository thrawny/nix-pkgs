{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.7-nightly.20261102.4093";
  srcHash = "sha512-HLYtCLtIQZNMp9uKYYHoiqGe8VIwYgHtSC0qte9xiLSQ3ktotZwtWEo41thNl6AUbZWZN3TICySROOEkTw5xlg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
