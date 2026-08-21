{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260821.1151";
  srcHash = "sha512-gT4wORjxLb7/2EqO32s4FUEtpia2Lbftw/E7cE1LDMrVTLivplfBk6S21WUp79KfLxtcLJsKJGjnmzDYHNCaIg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
