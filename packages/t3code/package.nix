{
  lib,
  buildNpmPackage,
  fetchurl,
  importNpmLock,
  nodejs_24,
}:

let
  packageJson = lib.importJSON ./package.json;
  # The npm tarball ships overrides with npm's "-" removal syntax. Keep the
  # checked-in manifest for reproducibility, but remove overrides before npm/Nix
  # consumes it.
  packageJsonForNpm = builtins.removeAttrs packageJson [ "overrides" ];
  packageLockJson = lib.importJSON ./package-lock.json;
in
buildNpmPackage (finalAttrs: {
  pname = "t3code";
  version = "0.0.27";

  nodejs = nodejs_24;

  src = fetchurl {
    url = "https://registry.npmjs.org/t3/-/t3-${finalAttrs.version}.tgz";
    hash = "sha512-quBdb42BXXKXxyfqIFEnvCYrMndzw92JbAoIPkDZr2aiGfRyLT+nyvDjcJjK2IHSO9ZczEmda1Fx8spBIEX/HA==";
  };

  npmDeps = importNpmLock {
    package = packageJsonForNpm;
    packageLock = packageLockJson;
    fetcherOpts = {
      "node_modules/@effect/platform-node".name = "platform-node.tgz";
      "node_modules/@effect/platform-node-shared".name = "platform-node-shared.tgz";
      "node_modules/@effect/sql-sqlite-bun".name = "sql-sqlite-bun.tgz";
      "node_modules/effect".name = "effect.tgz";
    };
  };
  npmConfigHook = importNpmLock.npmConfigHook;

  # The published npm package already contains dist/.
  dontNpmBuild = true;

  postPatch = ''
    cp ${./package.json} package.json
    cp ${./package-lock.json} package-lock.json
    node -e '
      const fs = require("fs");
      const pkg = JSON.parse(fs.readFileSync("package.json", "utf8"));
      delete pkg.overrides;
      fs.writeFileSync("package.json", JSON.stringify(pkg, null, 2) + "\n");
    '
  '';

  meta = {
    description = "T3 Code CLI/server";
    homepage = "https://github.com/pingdotgg/t3code";
    license = lib.licenses.mit;
    mainProgram = "t3";
    platforms = lib.platforms.unix;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
  };
})
