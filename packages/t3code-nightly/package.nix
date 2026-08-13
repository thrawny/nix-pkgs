{ callPackage }:

callPackage ../t3code/build.nix {
  pname = "t3code-nightly";
  version = "0.0.34-nightly.20260813.1084";
  srcHash = "sha512-IxjF/J4L6mkHKW6824XjL4fCZuHBJz27ZQWAFT/JE1Hvc4dFeDcXerltX/M12EFYs5sqyYonj62ZDUzGOYZKTA==";
  packageJsonFile = ./package.json;
  packageLockFile = ./package-lock.json;
}
