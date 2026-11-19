{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.11-nightly.20261119.4941";
  srcHash = "sha512-4r/lC3Q4rijQMLKErhjvx5LCvwN0+QhvdiHmeqghfaRpLyfJkYtX0CZnYNsCemGPUeC2zoigC+hiE2a7MnwWLA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
