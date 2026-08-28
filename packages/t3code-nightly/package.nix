{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.36-nightly.20260828.1211";
  srcHash = "sha512-zLQ5T4wuxE1p4ozQcJoxnbAWlbzFc1qePlnmC+JW1f0Uax3xEaBdKwlqoqADRXr9TlZXhM7uHrGiPCZGyHQAlA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
