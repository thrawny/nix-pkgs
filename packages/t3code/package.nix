{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.40";
  srcHash = "sha512-lvyH1fexahy7lVXNNWP9FUE/IRlYFKEt5DksoscftVY0VBDQ3LBVrKbyYd5iiHWXr1Qun3Fcbf+kXsIP+75wjg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
