{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.34";
  srcHash = "sha512-n0wANFpl7KufqmVCXI1mYZJ2WFORBo+C5dfEiG7NGDZWmUUc0p9FQ/Ic4VkK+ToVxA1uSxVgUVI8gXNU62k3LA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
