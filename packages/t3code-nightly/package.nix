{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.8-nightly.20261105.4234";
  srcHash = "sha512-IU/a7NjZlPf+y0HF/EZ6PDVT2hLOz+q32GRgk1nRgU4SFAV3wg53Qk/HhfPjsQHY3S7wDSx0XqwGBMYpg8nncg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
