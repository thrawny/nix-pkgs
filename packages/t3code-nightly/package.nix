{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261003.2632";
  srcHash = "sha512-tk8n47hTaj9PJcKvTOXu7M8XetKD5hyb8F2aUi1MF5gppB3+fai4eevEazE5Udcd3sUDjLeChkbM8ZueSCqUVA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
