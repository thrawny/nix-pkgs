{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.38";
  srcHash = "sha512-lGuIA56nrE3ofnm6wwLWOGgGIX79SeFmX62hPw9AMXSt0k19p+Tdj3/BOC7qkhbKTV4RGucLw033ksXRY3baqw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
