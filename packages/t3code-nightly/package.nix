{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.37-nightly.20260830.1227";
  srcHash = "sha512-yCLUgxcfvV2gU1liN10hIjDn1PjkgSBvsMSqa7hG4lvpSJkuk7VlEXTMQuSAOckHe/l+9K7RaduyVFjuTMPp+w==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
