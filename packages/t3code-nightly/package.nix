{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.35-nightly.20260826.1195";
  srcHash = "sha512-9mjOzmYUYjcclASl4pAl2JvNmjUHHfD0cVssRlFX2f7ZPgZgP1TghyrHg5zaxtvlW1+XB1fWOGLNSKKunRV5PA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
