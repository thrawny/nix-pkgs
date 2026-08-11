{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260811.1067";
  srcHash = "sha512-vfqiI6IReWh4X3+wGu+R160FQPqJndqe/J+ulkk57p58PpoZXx6PNJNa0eb4/+95BO1qUR/z+xa2rAJG3SxmtA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
