{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.13-nightly.20261125.5258";
  srcHash = "sha512-Uyk4dRrV15PVg7NZ39gCDP1CVmxLmu/GE9ZAqMnhf+4GFC2HPcQQh7ReFLuU6cqIxVdGp4U+DR6kTxYPrjnVCw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
