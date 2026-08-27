{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.36-nightly.20260827.1206";
  srcHash = "sha512-/RVuHpkNCkEgeIzPrwJyyfGJmgTKADAYkyTOjWG22x+VLxgubELA3BzDBR+uhwot/p+sVGEmJRYD1tEz2YB36w==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
