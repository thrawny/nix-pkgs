{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260926.2282";
  srcHash = "sha512-OIobBH10hH5LcuJ9v8ZMnWeAcxW/XRbJIkgVZAd7T1MaEJPBZCe5kfZEUwIZUYWE5F29de221Z8lVFPrBYeF1Q==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
