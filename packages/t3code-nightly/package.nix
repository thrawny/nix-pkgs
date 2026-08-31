{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.38-nightly.20260831.1236";
  srcHash = "sha512-jzyVzXbhsyx4Mpodbj8rzJ7dTOqhsElvKbY0P/lns1/JvDG8OZtuPvyRVpXRP2azm4sX346WL+BfOWcMyUe2vQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
