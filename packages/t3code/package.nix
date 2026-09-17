{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.42";
  srcHash = "sha512-B/BiAR9qwG+smhUj7b+R8V6rAsmYMyj0Sz50/KbBMmAy2DhFJdj4PpcAVNWabFHyyEksVtAxYuWjxEa01zg/sw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
