{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.8-nightly.20261106.4275";
  srcHash = "sha512-ky31/uh16o07yNf6SuuLsWLeCUgRlbETQJ9VX0G6wmASGXDlIh7X8w3m6Qh2xdz/c7+EEndNg7ersDgO00uYLQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
