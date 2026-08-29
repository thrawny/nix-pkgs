{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.36";
  srcHash = "sha512-q4Pm/6RoD2JmbXCVipS+sypKJ5Iu7jZCShamaInK75/l+sXSZQHa+rN5egZWKGgBz8QQgBMcaNRQvqOAcddjkQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
