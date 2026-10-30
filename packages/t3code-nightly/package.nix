{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.6-nightly.20261030.3917";
  srcHash = "sha512-MT1sblXo1eOB0Zt1zagQn+5pa4U+RtzIEZFA5ADetWdln4hpQW1I4BEgVgwjR8i6JENwvjywaX82oTDaPSRahA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
