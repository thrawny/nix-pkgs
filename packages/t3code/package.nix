{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.1";
  srcHash = "sha512-3wxtE+rq+hXuIJfkSWaLUXX+Ds2xi4R/8b/fyqQAMsAiqh0YImp533NbODROcYGagJ0GQExA2nEAMdgundzGlA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
