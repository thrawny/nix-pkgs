{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.45-nightly.20260930.2493";
  srcHash = "sha512-PejbST7E2D67e3+1Vgz4TFl1tAP4JWjTX/r3vWoj5WG+zvPYvVIw8Iq10slT8zD72umpGMgLWC3LG9eKWncWbg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
