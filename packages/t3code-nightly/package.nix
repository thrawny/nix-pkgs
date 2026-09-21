{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.43-nightly.20260921.2058";
  srcHash = "sha512-2k2Me2t0nSrzys74WwBwTEN8VrwYvjrQo/iYEf65XsI/eSa4nAUfqqhPnLMZpn9qKGay7y6ZIf3v2JTCH6kC+g==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
