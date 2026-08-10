{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.33";
  srcHash = "sha512-TpXtftAVkRi5X6Bse01WKNISyrflXMukOppMAH9duWMw9hswAPI6IChjNNaxHXI3ZfcN5CgKoNmh19XCvrOkYw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
