{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.10-nightly.20261114.4695";
  srcHash = "sha512-wvnFS8qU955oK/oRqKd55sQPyldWa1IHVL21aMeMj34G8bFMgRIaBbwvoNKQLEgmMZdTn1/0R9F2Rye36dzpsg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
