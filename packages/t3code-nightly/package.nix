{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.39-nightly.20260906.1303";
  srcHash = "sha512-7+YN11QsvEBDVm0MXs197fC9CRVGU2Zrnnvp4BeYWYM2yD/roGx8aykqLbBCLJV+BnCn9vGxZ9tbfL4+D7Z6vQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
