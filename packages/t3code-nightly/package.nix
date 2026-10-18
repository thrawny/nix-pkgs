{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.1-nightly.20261018.3315";
  srcHash = "sha512-VA482cUz0+CB5nS0y/B8KZOKou/6bWHueljZaPUOORzZJeifWmhlLHnCp1kYvdaRLREpPKj1EiYSzlhTIZyyZQ==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
