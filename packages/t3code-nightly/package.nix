{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261011.2980";
  srcHash = "sha512-sUu8zuZtny11KpUoT7KnpwYFVn8LSlTR47CyyUh5mjMyBW2A3TNWEt6MNd+CysmdWaaDd42jOhRPDMTpgcla5g==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
