{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.7";
  srcHash = "sha512-xYwnF28/0pYox9YkwkFKSpdaaIYFm1sVsPxsb0Z6WQobPAxbGp96EDWFkcrvEBd9vYKAceUX43txeiROeTTfNw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
