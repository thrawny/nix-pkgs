{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260927.2344";
  srcHash = "sha512-mE/7WWZCVvSJvPba+ViOo1/QSH1g023sqgQmTfGvgI3pEgxCe6kq6xOhbio/ehlkTBTvum0SE+1aEvXVWGjQtQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
