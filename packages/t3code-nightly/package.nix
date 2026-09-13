{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.41-nightly.20260913.1658";
  srcHash = "sha512-fIhkIorjKTCD+wzD3TX1Ggxl+TP7lmNZnn/y2V4hr3K2w2IvmLpipOXy8693fz2+gjOFhRlPY4PGcbdKoBhc3Q==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
