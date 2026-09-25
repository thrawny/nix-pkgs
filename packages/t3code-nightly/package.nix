{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260925.2251";
  srcHash = "sha512-JA3vXljv/YVBkwCPAwtMPDEdUvTiskXThLazvy7cSdnb9on1ObutyYDmnbnhTPQJCrkfPerQZvwAMoCGVWii9w==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
