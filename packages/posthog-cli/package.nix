{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  zlib,
}:

let
  version = "0.8.4";
  platform =
    {
      x86_64-linux = {
        target = "x86_64-unknown-linux-gnu";
        hash = "sha256-fwVolGatvGCAlYQUHK3LB6oZLD5lu6+v2Pq2BWV6bWg=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-gnu";
        hash = "sha256-rSetgetjxubPqhoRSqoW/2OhDu1EbKuBdx6/j5luznY=";
      };
      x86_64-darwin = {
        target = "x86_64-apple-darwin";
        hash = "sha256-AESmizjkL1Erwk6SYzG3X/8CnjJVhM7AY5nod+eU0fI=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-7pEPXprg+xFlvc+zA9MZIQSQOi0AMZD0V0mBjI5ePdE=";
      };
    }
    .${stdenv.hostPlatform.system};
in
stdenv.mkDerivation {
  pname = "posthog-cli";
  inherit version;

  src = fetchurl {
    url = "https://github.com/PostHog/posthog/releases/download/posthog-cli%2Fv${version}/posthog-cli-${platform.target}.tar.gz";
    inherit (platform) hash;
  };

  sourceRoot = "posthog-cli-${platform.target}";

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    stdenv.cc.cc
    zlib
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 posthog-cli "$out/bin/posthog-cli"
    cp -r lib "$out/lib"

    runHook postInstall
  '';

  meta = {
    description = "Command-line interface for PostHog";
    homepage = "https://github.com/PostHog/posthog/tree/master/cli";
    license = lib.licenses.mit;
    mainProgram = "posthog-cli";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
