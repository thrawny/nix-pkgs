{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260819.1133";
  srcHash = "sha512-MZ68oWbL03BCM9mRmSKttsVQrrOsGBZJt8u2Qa2Mbq5Z3p4dlO8fxo1cQL6HkDUoUiz96Y8eQ1x8BZUS8f+NTA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
