{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.2";
  srcHash = "sha512-QEsJOSU8qUnOlHFPPF/w4sAEtjkt2wzMWIoNoENd+uC8ddeFSqclcFJDA2+loqvBCRKGpHfQibGTXwntYc83Eg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
