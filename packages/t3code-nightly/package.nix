{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.7-nightly.20261103.4138";
  srcHash = "sha512-jc29uG+GUWck7BNDlbZudBjFBFE/QwATKhtbaqTbzWjwOSpelSCgbyidVQF9oMqRSoGP5VCKGxjH1njCdvvKMw==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
