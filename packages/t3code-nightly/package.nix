{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260820.1142";
  srcHash = "sha512-rgREgY5DnTirSDQhgjXFUfTGJFyQWCGjb+rEqy9RXfs6ZTQk6og+I7swZ+XT8rxyFK/oW9ZmiWlK0PCnETVqow==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
