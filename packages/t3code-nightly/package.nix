{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260817.1116";
  srcHash = "sha512-aRFXUC0l2Rv3u3VTR6vKgWgrSnOIfDYizKYUN4J0krzuEz3Qs7yjZLBVaYV0kw3NlG/mV6/9B6ckUPWMmC5tkQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
