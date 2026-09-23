{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260923.2150";
  srcHash = "sha512-oAp9vE7TvI86t7Is/OuuFEHuSJ2BZYF5rKHoMLRsWyR3/PvrYK0eL6ZZp6G4to0RlLygnwrHHUTeFSl3JlXSSQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
