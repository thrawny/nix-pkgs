{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.37";
  srcHash = "sha512-/uSSgJGs/t9r8D5T54sdcFssSOauM5FxwUMUOFATe5N2OD64S594VMtIG7Phbfrllmr8adxBOVrFtD4+VegqCQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
