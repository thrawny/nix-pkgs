{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.1-nightly.20261016.3218";
  srcHash = "sha512-uNij2r8rrg6fZy9hL5MEmkmbmnCGYsUcGcYSp7sSEQctqr76RSrFd/96ZEc9k49coFqCLvWQZr8usjSDMcgkzA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
