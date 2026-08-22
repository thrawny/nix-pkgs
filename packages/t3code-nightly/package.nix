{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260822.1157";
  srcHash = "sha512-NSVu81hIH9XQSnmB5WFWvm7Qis552aXns30BEcBm0OPKnLF1uQaCteL3GGtagunD8OKMEijtI67qNqDT7VL+3g==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
