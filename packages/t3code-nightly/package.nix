{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260814.1093";
  srcHash = "sha512-Le3OLaSnWtIJ/ibBgeRLOUGwckGYa1coo3UAgPx7RVRQ9YJHYhKQkz3dYRjhnu4VUgL9B5BIoUn54BsG/ev0ag==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
