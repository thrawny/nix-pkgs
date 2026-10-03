{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.45";
  srcHash = "sha512-K67qRNKWQHdIyoQ8oCP/cK7lG9y23a1bDNaSsdGkvWJTVRySVd9nvYZS49LW6Ap+RF1nR9QBg/i4s0ovDHi96A==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
