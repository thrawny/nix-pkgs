{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261005.2702";
  srcHash = "sha512-ktoTYJAFYYBfSDqQ+AMsPakAwSkJGda746GGGrzKELcHXwZe6FY6kRDcK6cjVNQt+tccCpqo00cVMmwbqjB5CA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
