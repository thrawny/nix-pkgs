{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260810.1059";
  srcHash = "sha512-eJ0ejrKgLDUuLFbwRf5axRsqkhpBvxJqaAstlkkE0Co1tuP+hH438PIwQWhKS+tyElVz7tFI3Ha62le4zGdaJQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
