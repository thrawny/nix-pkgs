{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.11";
  srcHash = "sha512-LwGw1MBUrKJfqjTl/75QpAPbD3TBoyyPA8NgNrQh0yb0cQHGzoOBYuHcZa17rRcbLAULGCf9Bn/9ntEYUmxlLw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
