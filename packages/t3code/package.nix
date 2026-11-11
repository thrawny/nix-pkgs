{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.9";
  srcHash = "sha512-kcSIUmdrRmmDYy2LSdiYDUnz2/BjpyzJiBEAQjH3vfR6tCKBGSMst5Q5Ds/F7CYzSc/5eLdAoXt/6NMYWuZKMA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
