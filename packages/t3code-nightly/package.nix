{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260824.1176";
  srcHash = "sha512-K/Xhj7eFEk8nPUKHA4nti+sgFv4tF81d8LAyeE9eaqKBtoeaPWi64Ngo3UEd0kxW1HZO98lkFAJCoNxxl9py5A==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
