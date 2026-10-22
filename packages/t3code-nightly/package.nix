{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.2-nightly.20261022.3526";
  srcHash = "sha512-3yjdcwCePY4KMir64Ib8ky07YSGq6TiljNvxDma6qcmXEPsJJbIVFndzjJtD4vkUhDkqQsS6z4yCBawHO9ViWg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
