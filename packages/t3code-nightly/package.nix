{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260815.1100";
  srcHash = "sha512-CsLGV4S75oCb5i1NJ/6N7rLlo444wBg2d/K1F+N8ng8i15kl2WjjDAWhu71ZVwgeMukTTl1xt156fSjPfjmt+w==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
