{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.10-nightly.20261111.4529";
  srcHash = "sha512-NdGNayN6M+1PTP6zezhTxm0Td9Q4zpI5VZZk6edy25c1N6AYnNW58NLt/fk86hmX9hhAGzuWLF2jkxghyU2xjA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
