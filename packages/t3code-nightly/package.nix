{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.8-nightly.20261104.4179";
  srcHash = "sha512-z5n6bg43X1KO2TH1zXpWG294eA7o57FZDcA2GJ8TFCucxS2gCtiX9j8WTjfxBqu9JrIXjClSsbE/P35oVEEFqA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
