{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.12-nightly.20261121.5051";
  srcHash = "sha512-DgxgATNyvUiHAjG4abJEGbSbboS5oKxD0OzHUiyFounLuNmST9bU3JLBeyuVimep9lCjnCUwHi/mSSw8Sh6HsA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
