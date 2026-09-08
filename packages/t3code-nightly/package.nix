{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.41-nightly.20260908.1400";
  srcHash = "sha512-mtotmPNsQuiAFASbbi/PTZBrac4QWdmqsZoR7cnkng2IPTUssJ/7/l3dcavTX4x2XcSgzCdxuYY+jzqjm9OG5w==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
