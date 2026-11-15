{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.10-nightly.20261115.4736";
  srcHash = "sha512-cB6oYPWgGkDzmbJVLYMzgAVGuZdy+7jHlqO+zbVIRK1RI/Os1MJ/UCjhM8/rriRpertkP0mcIxoEHrsqOX1Srg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
