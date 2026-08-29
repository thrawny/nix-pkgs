{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.37-nightly.20260829.1219";
  srcHash = "sha512-eMub/4BcVaz658MYeVyD8UE1kqG+lzHyrkk58bdaIHPl5Z9rBZDIqkSzqu415riUtaSPYVVG2P1pTeXTCktslg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
