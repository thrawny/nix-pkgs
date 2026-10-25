{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.3-nightly.20261025.3669";
  srcHash = "sha512-GVcrjB+1XYeQrRFHKO4zyE3wMdvBYCFYxdO+xHrb3fpU6YsatnAD2FdgaKMGD9Asl7+Gge4z/81vHMOzekZZpg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
