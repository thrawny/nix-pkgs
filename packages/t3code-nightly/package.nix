{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.1-nightly.20261017.3238";
  srcHash = "sha512-TtNWqq5qC/r2QynTYAi1mMI2wQdMiuTW4Goz+YVtjVVlPZSoIcc03harRs6UHSl19FmBynzVh894JK6FD3YuSw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
