{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260918.1895";
  srcHash = "sha512-SwlsWND7HKwDqHw0bkbubhwRe/esm9sxdPCFN1cD6yLd9TF7pin8geYc5HSeBOs924YwfzIBGoCR3cXq5UrunQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
