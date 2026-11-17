{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.10";
  srcHash = "sha512-D8VJ+g6aBXasNw+aM9AlzSf4UyY2aE12TU0E3UF5fe0PSunZ4vkGSLHEO316+uQYNqVk3k7eb9fO40rJr1if5w==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
