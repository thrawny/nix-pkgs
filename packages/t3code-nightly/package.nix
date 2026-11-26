{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.13-nightly.20261126.5305";
  srcHash = "sha512-FqcV5iw8j5vfDpIv43t7D7GGrdNqrTbxqjAl4whRxtu10gCrJgRQgM0ZM7RPnHuRON0ivCe7cdmKexBvOnO7nQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
