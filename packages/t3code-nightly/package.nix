{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.1-nightly.20261019.3360";
  srcHash = "sha512-5kHFQ6+8A8c1/02njXROTQDTr6sL7xfnTNnAABZAKe5o77a6mRqOfUBJYlMliXYSfeGePwMtR/cvYJKzIw4aNw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
