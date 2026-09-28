{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260928.2402";
  srcHash = "sha512-tFOovACHHDIP6qkzW1HN8CisJ7EEIlvw00F63OMIlk3sfpDBMTcdzvIUXzbJ0ugj3l/1Yy1ibQ26lwVsv55aGg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
