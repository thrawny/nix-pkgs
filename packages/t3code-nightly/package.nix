{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.38-nightly.20260901.1246";
  srcHash = "sha512-THZ4eOmckh3ZlRCyjmXAXcl+ssBJM/w47PHwvKIkZkfBqQ2beKcs7Dr/jXG5bPBbysnHhgZRikZMix+oRfu1Pw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
