{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.33-nightly.20260809.1043";
  srcHash = "sha512-VNQaf6el6gSOkj0AtwWosiUYvhDQpNzmv1WBmFxtw+91doLybbzQxyBRl4GkU/sBgOErDyLtaG6w7aDZRVEF5g==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
