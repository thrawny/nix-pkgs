{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.14-nightly.20261128.5399";
  srcHash = "sha512-Y4w6WYBzhHMAaKnq0UrFgT9dK3hzSt0J/PqCJccLgqzaLT+/zfmSDR5G0ZlRfp8IlM6juoi4KR91Cqga3sT+dA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
