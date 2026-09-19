{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260919.1962";
  srcHash = "sha512-ZQB0/uYeZyUey75Ottjaz8EAiwSkOwah6aJ5eia2qTMbv1Rr1Xqm2ZRYTTnQgSUT2NuyK4GKgCFUdYpY/PlSdg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
