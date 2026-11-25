{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.12";
  srcHash = "sha512-qVERRybGKGgFNbuFyYy51VrvAXTJouUG1akOexjFOntGlTNLZ9b8nlSnx+0V4j7ywBXY4SIycRNcsOjjFjPhIQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
