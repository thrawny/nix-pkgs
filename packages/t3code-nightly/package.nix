{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260917.1866";
  srcHash = "sha512-F8AFSHJvWieHhKULjBxDxBT5Iycx7wXBXNCexu+Fi2J3/8acWoRv57ROg5Smr4lE0o5QoAvF+v3hyvOwzhZWqQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
