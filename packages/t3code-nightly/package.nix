{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.45-nightly.20261001.2539";
  srcHash = "sha512-Z5c0JEYN6A5rzGPuPGrvwUU4vtaoZUmMNI1wZKZCuD16nlAb3b3+1vH362u5+AkwcgNC9C2Mwpw7h00Lbt6bgQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
