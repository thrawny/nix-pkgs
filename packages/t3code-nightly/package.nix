{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.12-nightly.20261123.5151";
  srcHash = "sha512-gpbhJ39XTj5N4jQLu9+7VurxXLGFwxRtS1iWVHN+KiWyQrjit8HCpKizXZ10+xiT9tWu0lNyaPgfOCNIS0f+HA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
