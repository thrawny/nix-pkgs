{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261015.3158";
  srcHash = "sha512-XjierBjb/VQn/+YHjbjqM0mJWyP5hPkqsXy22Qn46tSbAs/8dArgaQz3OmYA0sz6GDvDlnv9LV4K/MfGw87dUg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
