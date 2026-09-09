{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.41-nightly.20260909.1439";
  srcHash = "sha512-1i9+nZ276mqUb2RHJ6P94Uik17cmBKvICNImWA+VPSftoOE6eXFEmbMcVL4M8QRyG7SxfZUoSZsRjzN8sRduRQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
