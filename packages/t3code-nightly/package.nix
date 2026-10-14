{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261014.3105";
  srcHash = "sha512-vwRf+4XpINbRaQTR5PpUKkf0dReW5TKT+svB3rpXRqXvDpx2ZEvhioEPNKiPVUsz8aRvkX3jA/gqqfjC5P7gyg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
