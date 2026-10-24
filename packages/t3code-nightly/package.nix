{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.3-nightly.20261024.3617";
  srcHash = "sha512-GhCNfph+B8VRR7kyVA/cIIBWezKYyIhHPMhICm0ft6YIlGxtUTUgoLAwz9JvTwHm14ThATaWt2TUrgaYwVIOIg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
