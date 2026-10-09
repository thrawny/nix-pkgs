{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261009.2873";
  srcHash = "sha512-8bRmrmwSXCMKIxe2KTiMW3Uc9fRG1jZ2obIO+VA/PbrQNOQ+5Z7CtEQwPVlJW1R1GgjZQuFU82fgiGSsmavtIg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
