{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261013.3066";
  srcHash = "sha512-6L+o3WBKiXKjAtaTbJYJDKo3GOnzlvBJ5/iwfgacc8i/zWoy2i70L9ZwDKcMMUjF5thBoru3W+DcohSw2HetIQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
