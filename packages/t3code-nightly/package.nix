{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.4-nightly.20261027.3770";
  srcHash = "sha512-Fl0QZKCm+kAujseuBDELkl+buZm34WFkVel1UEu5WxIMyovW72DOKbSI3wyQ8ZAd86JXyE3mCNNk9mvSNYlx1A==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
