{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.0";
  srcHash = "sha512-kesDReGXOxh17i//xe6UIGtYZDIZBZBJeZ7CFAsjLugRBz89La1sbx9kzEW60hkjnheUikMOkdkvQfR9QP3hHg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
