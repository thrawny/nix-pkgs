{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261008.2833";
  srcHash = "sha512-qA4FbZqoZCn8LsUzaQOTbcLLyDVd0NfypuUavZEONwElz6KoykO0ufe/B4Zjs18w+ii8PKmcX8thH/jxK1c1oQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
