{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.3-nightly.20261023.3579";
  srcHash = "sha512-gu16UnokNIGYGoBRylVw2lqxhcNQZT1eEitZLX2RTd3yHguF8kahhuwxyfuH7ZRX+ICY6OEoCQh4a1qBq2WU5Q==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
