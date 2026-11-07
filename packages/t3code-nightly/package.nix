{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.8-nightly.20261107.4327";
  srcHash = "sha512-ymN/BIBj1tsVAd9ylDOQd7Fxo/N6i64dRSIHlfQ4qAUs+kmk4OhxoA76j3ldtNPs9dXjKYk+ThRbdCmbdsGnjQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
