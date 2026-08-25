{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260825.1184";
  srcHash = "sha512-6TA/NglMpQwdHu2bOAR+swgKDQXPuADp7Rx+/6/iUIucO8wwc9DCqJUJZj4zdirGj4il8oJpE3L8Q+fqEgzG7A==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
