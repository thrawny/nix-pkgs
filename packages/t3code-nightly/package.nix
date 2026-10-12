{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261012.3021";
  srcHash = "sha512-RbstkmEteRK7e8iALbLYHBcnlcatI83ePv9sXoMiNyqOAFvtJjZpJHZDFfC3FW9dGKA9RK1l/j1CQQuBaMQgtQ==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
