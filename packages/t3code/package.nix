{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.13";
  srcHash = "sha512-eZwvOo6N+zZb9g8vK1PYI7S3kOeVyjcFLOAME3YVbpvRGp6qZo21VfBHRCgOidoJGWiUdNRtFkIEGUs1I1wTSw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
