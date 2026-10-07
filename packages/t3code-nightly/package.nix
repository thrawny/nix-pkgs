{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261007.2774";
  srcHash = "sha512-/o5eG4JFd5QzcSLcY6tA42TjlkucF3LbRiljcO3AIvnQqvAeKLzhI+uzVrk84oGBItU9Aaa1cHu2O7RbJ3XfDA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
