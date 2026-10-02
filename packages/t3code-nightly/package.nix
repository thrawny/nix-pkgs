{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.45-nightly.20261002.2584";
  srcHash = "sha512-40BELxqcDkLEH0XcvvEFCCxBeo9Fgy/ebKRZBITON1zV4an4nOoltqMtr2bDuk//6sh7GijYkfI/vIbooISGtg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
