{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.3-nightly.20261026.3726";
  srcHash = "sha512-6grSq30w41BZGh4OO3N3rnrWpXdPnMiSDMt/V7A3kw0WAGLMtLVjMd/OF+FSNKT2A69tL3z8hjGOoyIbjzzOUA==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
