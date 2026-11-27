{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.14-nightly.20261127.5345";
  srcHash = "sha512-Ami8rZd98H3slACSpQ19w37TCh+4S/QZlYTxnJ47A3CpyyasmpLbHU8ZW2KqKrEPY5sZPD+SzPmrNhzMeqQw6Q==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
