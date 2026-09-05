{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.39-nightly.20260905.1287";
  srcHash = "sha512-wFUP06WnoIV/A/Ocu/Bm4Anz/ibaoiJDszYP1+eTKHKxOlSaC5ias2yAYGyqVSXihd3nt0PmhBUsG/mTg255nA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
