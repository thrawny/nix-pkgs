{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.9-nightly.20261110.4478";
  srcHash = "sha512-vPMwR51qKV04NQgbvLG7qDzBT+3OI0XbYjy+p+Bc9w425k9dlDP5JFllHFEpgsOsJsfQq52o2AyHL00CIVbhDA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
