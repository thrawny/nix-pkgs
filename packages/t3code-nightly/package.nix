{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260920.2005";
  srcHash = "sha512-MoFEZOM4EFma5Fggjq/13AL6zMgYfZPLiB6+Rr5NXg79+VIi9df7hP6FH/S7G5hTuRdNoecrVhD0JLEhpZr0Lw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
