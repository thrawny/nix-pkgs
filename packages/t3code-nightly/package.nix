{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.1.11-nightly.20261117.4838";
  srcHash = "sha512-TZER8IE89+VMcAuMmiTTP7DYnAHPwx8KIpa6ba7eDQRuRpLlSzE1QE/fN9cuvZtSjedm/zuAbORc0y5M95LWOg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
