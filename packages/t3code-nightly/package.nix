{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260816.1108";
  srcHash = "sha512-EWtBU5bkTFz1qj5KQ//1H2GYn4dvSCNrsrTU0QywNBsD3NZtZllZsKw8BRYVdoQPW+7+XT27+D9RySv23JZAvg==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
