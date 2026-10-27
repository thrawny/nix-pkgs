{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.3";
  srcHash = "sha512-uCAxU2R3Am5Euagy7YtUXGM+bxjvGsFJ480/I1KdhrJwGjIdfhSdseSUM/X25Gmi7Ccw5cZ5+YE7WsN7o+VDaw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
