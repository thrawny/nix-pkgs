{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.8-nightly.20261109.4433";
  srcHash = "sha512-BfSkgz2yASUtpC8FZaNaeFylHh7EizULKWmLzTtTIGm1qLdj4huUsHuHqt44KmrRg8+17O20aL4EE8iRprtM/g==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
