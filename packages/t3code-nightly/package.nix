{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260823.1167";
  srcHash = "sha512-YdAmtDCb3vk+Td800iMd7l5hpCnAvD0QSpkxxd3JPLnljECrvyqoY0Apl/wRtA60f6G5wxhU92Pm7XLWrtJx7w==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
