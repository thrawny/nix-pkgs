{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.39-nightly.20260904.1277";
  srcHash = "sha512-bkB+ohR/5+n1pPUfbgOiK63F/jAJpwrLLEtAxmsI9JHyZXPwHEZEpQo+Q+SrpnHEt3KhDmbEvkNsgUHFpiTL8w==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
