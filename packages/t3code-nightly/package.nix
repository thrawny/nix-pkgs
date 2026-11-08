{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.8-nightly.20261108.4367";
  srcHash = "sha512-sgOcDTUkwgIFrVv2UrrOOLt0SQ2r3obcpyZTHCCeez3m6rpaSZey052y0VZnOL69ndmtu3q5VLSFy3JzhYk9tA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
