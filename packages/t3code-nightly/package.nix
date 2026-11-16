{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.10-nightly.20261116.4800";
  srcHash = "sha512-B+js7hKCwThIMCj5w/p7lSBeEOOGh0TiEJg9abuNaFtzIB6/+8OEr4clQ8btnJN/S7A6cQHRuREdSGbTMBLuaQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
