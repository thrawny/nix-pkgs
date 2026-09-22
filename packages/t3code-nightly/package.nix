{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260922.2110";
  srcHash = "sha512-1scEu4VmXStzBMjQP5GtNgr925HwbyymvXpUCg2gFGqHoRUt4xtOm9m0u96PCYH8IvUavjVtkLK0ROZUD8GDTw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
