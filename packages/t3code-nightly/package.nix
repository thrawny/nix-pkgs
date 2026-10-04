{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261004.2648";
  srcHash = "sha512-vp4JJ1M94CHXG+4yljylDrSjeoHJCcF0Z5ses67GHY5ILHK5VU8HMeNPf7qq8BrjZxz6KI//nORS7il5/WxAMQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
