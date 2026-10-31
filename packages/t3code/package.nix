{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.6";
  srcHash = "sha512-Gxiu4vniyTDKcXlyzA8yRQ7/xDB7DXork97rFbX66NXH7NGV8NJPBZi0/+tEMS8KmkUK4rVmPH9zMFKiWe30mg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
