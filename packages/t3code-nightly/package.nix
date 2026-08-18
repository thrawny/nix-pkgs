{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260818.1124";
  srcHash = "sha512-P6J977XFOW9mKWHXjHqnTa7Ejrcbt6Zte2ut3B3mFRbIJEmtuOF7P/x/E/0pT+KLi6UnU5gD+Hshd3Umr8EwdA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
