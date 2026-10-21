{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.2-nightly.20261021.3473";
  srcHash = "sha512-nx/RtXeDAKFyWLAG9wOEzV3Ll2tj41YZxm02d88wipBb8wgAe4xSgbW0iz5l0WHt4vYXWUlyrmlJj/53lwxOFw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
