{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.32";
  srcHash = "sha512-txYqUxdSzRotLPeRw/zs0MWAHqqFq4VSNePJCGiHmFoxsOg29kWKfYGJ0VasbjWKGI34/q4+9jlGubhXWn1+Mw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
