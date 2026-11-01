{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.7-nightly.20261101.4035";
  srcHash = "sha512-m0Jc0OBP1mGPqullEItQaNNQp9ThW+jnvCos+vnR5gdtTReGdj8k9sFEWCPelLblNmUCQ5+/kRbMH/uddM1K2Q==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
