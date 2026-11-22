{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.12-nightly.20261122.5098";
  srcHash = "sha512-wSv0wVmD156feDUffxKsYzbtXpMjfkqZbRTJGOBzcc9Zf7fUoIvKCt/4PCYhIwuUqxQIF1bTKq2BPs5OwZnW3A==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
