{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.41-nightly.20260910.1486";
  srcHash = "sha512-lpYZnkGAFmdHj2dtgaipFTTu1kb6vo9GPIItkVoFJ6C8JN5b41aOPDmq4kPnVgFCcuMDdSXf85vqiHH/HzcMgw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
