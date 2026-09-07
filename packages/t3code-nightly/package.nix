{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.40-nightly.20260907.1346";
  srcHash = "sha512-GQyWwc188SqMl3FiMOXp0G4KrDIoZaYgW/C0H+MO4CLH40rvAQwfuXRLTYg9gGg/gggFh3ZJXyZWPOfRyHWQSw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
