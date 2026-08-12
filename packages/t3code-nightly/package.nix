{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260812.1076";
  srcHash = "sha512-azzwCAwo9k0C+9PqGI9WZ7OLoaVk3YVxH/DwsUflkdZMPMOS6Bq59JFHg7kqpB6M1ErqzhsWZU1RfuWO5iyvoA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
