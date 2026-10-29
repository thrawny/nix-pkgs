{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.5-nightly.20261029.3877";
  srcHash = "sha512-YKJ//ohRa6zq+39LG/3evbb9bM8YEH7oQCnOIcI9UnE95Jnj1uXYjnd4oGCG9jMkt7CLeMET23M1rqRwcahNPA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
