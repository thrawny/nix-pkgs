{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260929.2428";
  srcHash = "sha512-uUnF4aqwv/8iMGBi/uBG+hf1BhtPgxzDTVzGtkzrGHRH1qesfi5oOqpKGbpx/+VYqs32foKZCGdQzVy5p4H4gA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
