{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.8";
  srcHash = "sha512-d3DWllAgNVS8xQpv3R8AT7s6V8LpmnUouTb+X6jiploox2zU7NA7Q2UTQiLAqDlboBwpJ7OKxaE1f/Qnp25oqQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
