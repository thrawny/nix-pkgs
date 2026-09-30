{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.44";
  srcHash = "sha512-xUewTKiHquRurWIvsM6FMFMPQ6dyZUBerAmrkO5pAGX+0qDUT/VXJpSis7j1ROLI85bS6JAcYTws9dcDP2vudw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
