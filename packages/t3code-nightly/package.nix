{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.6-nightly.20261031.3977";
  srcHash = "sha512-Pgax6edJV9q2xgK04re86Umsuzv2N6arJWOfa7ZGVo0fD0dVA1v0Q/oj9Yun/F+MFFoTd80xMhlQT/u4eZV3RQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
