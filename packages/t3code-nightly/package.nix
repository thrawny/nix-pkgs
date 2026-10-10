{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.46-nightly.20261010.2935";
  srcHash = "sha512-VKecPaa22JX/0Aq1f3EcYl/w916PhS+722WqJZ7ebXUZ34D8BTksgZN3hrTa4pNOKobUtMSH/CvhTYgYzCbGgA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
