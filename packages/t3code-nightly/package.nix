{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.41-nightly.20260912.1599";
  srcHash = "sha512-wri/ETvd+lqtE3jsvhqCCwCioYP1y1P1LR0M5d9FcxpRsx5qGoX8m4OB/WJOpdPqZUya4dqxV2MAQ93z8JQVsA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
