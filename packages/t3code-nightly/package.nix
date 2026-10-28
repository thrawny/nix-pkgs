{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.4-nightly.20261028.3824";
  srcHash = "sha512-EJvD+lSbvIPeFQ1cGnEGX2MwL/i2HrtMRyT0I1ZWBl++t7HnKXfMWBLUwRi1n+r3ePP2uoXlCTME4hNQqGZRDQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
