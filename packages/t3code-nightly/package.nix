{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.12-nightly.20261124.5209";
  srcHash = "sha512-JkN4lbQDcQSJtZFh02Zsxjw7fxByU0oH7e4PWci/9HbTbxWWY1gvdDK4fzhCuqLaSQQEi5sZ4TpppU6QlhZftQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
