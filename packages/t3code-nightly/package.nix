{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.1-nightly.20261020.3411";
  srcHash = "sha512-rYSw8CFIbk1KXAVePdzLMA+IJTOcTXB/ShSdpQgMdVghq/54I+Ai3LghIRSCNpBoQcs4Otf1vjAG76h2h0NFVg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
