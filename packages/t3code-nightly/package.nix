{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.12-nightly.20261120.4994";
  srcHash = "sha512-KBTrDNkNXlGfqrNHMF68JECrEa362QRFfkkDbl6K5k/HImM75iNeRgG5YqQ/EGEL5jK9kSE9J8BR1tn2SMCi8A==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
