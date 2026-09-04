{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.39-nightly.20260904.1278";
  srcHash = "sha512-KoQGoXlEGIBI/L3qNRLHBQkrsb/dHjCpSpPRa1wKjHWsOSc9j1WbY4zWSR6/Oub8FNjSwyaH9aOv4bIKi5/7Aw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
