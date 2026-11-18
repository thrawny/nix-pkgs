{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.11-nightly.20261118.4890";
  srcHash = "sha512-y7KXyKlIY4IM5v36Vh8atxjExLJNVn0LPNfE8kJ5CSrpMbtCHUunTKkdTTuL41GsEbI0P04lIz/ygqlWMxythQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
