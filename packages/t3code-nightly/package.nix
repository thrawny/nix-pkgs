{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.10-nightly.20261112.4580";
  srcHash = "sha512-wVfzKz2ZlF/t909G/4frz8wjNDEZkqX2B5/7Nab9k6TRjj0AWlGlK+CM+t14kMcIxWhEw1ogbpLBK6TEt8wYZA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
