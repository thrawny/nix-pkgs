{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.35";
  srcHash = "sha512-8EsWqFFTFL7uHQfqhZgM6YEv7TFvciXtuy8PWw8uaJnPKhsFaJJGA/s5kPp3GPGtLIPJYhaMcthSJBYBkdw3KA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
