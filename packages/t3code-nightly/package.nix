{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.10-nightly.20261113.4643";
  srcHash = "sha512-fD6ormQC4VDNCSICrcXvC2vVgC2qkv3zlp/dD4WjW6881H/wbw94Hb72URwmb+4Q2n4/7QJb6LTSyOxmMulyzQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
