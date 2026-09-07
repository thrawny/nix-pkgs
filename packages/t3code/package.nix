{ callPackage }:

callPackage ./build.nix {
  pname = "t3code";
  version = "0.0.39";
  srcHash = "sha512-OvxnRhfy+GMmf4fUkLcjom5/jklqaAwOy3m/gSSbYZa7LyZWpjqOItbvJGA5SVzFwqJWly+mIV/185j+rxWcGw==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
