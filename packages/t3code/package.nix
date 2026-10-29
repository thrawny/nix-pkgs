{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.1.5";
  srcHash = "sha512-cc1jApovR1w7P/Ye5TQXYWxN4T1Q+7ETCMdiQPpm+WNdsyuWwe8cNb1erjiU7QVqf29FP2tGY7I+mLbsDinuAg==";
  releaseSourcesFile = ./release-sources.json;
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
