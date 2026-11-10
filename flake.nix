{
  description = "Thrawny's personal Nix package set";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        rec {
          acpx = pkgs.callPackage ./packages/acpx/package.nix { };
          firecrawl-cli = pkgs.callPackage ./packages/firecrawl-cli/package.nix { };
          posthog-cli = pkgs.callPackage ./packages/posthog-cli/package.nix { };
          portless = pkgs.callPackage ./packages/portless/package.nix { };
          t3code = pkgs.callPackage ./packages/t3code/package.nix { };
          t3code-nightly = pkgs.callPackage ./packages/t3code-nightly/package.nix { };

          t3 = t3code;
          t3-nightly = t3code-nightly;
          default = t3code;
        }
        // nixpkgs.lib.optionalAttrs (system == "x86_64-linux") rec {
          herdr-core = pkgs.callPackage ./packages/herdr-core/package.nix { };
          herdr-app = pkgs.callPackage ./packages/herdr-app/package.nix { inherit herdr-core; };
          t3code-desktop = pkgs.callPackage ./packages/t3code-desktop/package.nix { };
          t3code-desktop-nightly = pkgs.callPackage ./packages/t3code-desktop-nightly/package.nix { };
        }
      );

      overlays.default =
        final: prev:
        {
          acpx = final.callPackage ./packages/acpx/package.nix { };
          firecrawl-cli = final.callPackage ./packages/firecrawl-cli/package.nix { };
          posthog-cli = final.callPackage ./packages/posthog-cli/package.nix { };
          portless = final.callPackage ./packages/portless/package.nix { };
          t3code = final.callPackage ./packages/t3code/package.nix { };
          t3code-nightly = final.callPackage ./packages/t3code-nightly/package.nix { };
          t3 = final.t3code;
          t3-nightly = final.t3code-nightly;
        }
        // prev.lib.optionalAttrs (prev.stdenv.hostPlatform.system == "x86_64-linux") {
          herdr-core = final.callPackage ./packages/herdr-core/package.nix { };
          herdr-app = final.callPackage ./packages/herdr-app/package.nix { };
          t3code-desktop = final.callPackage ./packages/t3code-desktop/package.nix { };
          t3code-desktop-nightly = final.callPackage ./packages/t3code-desktop-nightly/package.nix { };
        };

      devShells = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.just
              pkgs.nixfmt
              pkgs.nodejs_24
              pkgs.python3
            ];
          };
        }
      );

      formatter = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        pkgs.writeShellApplication {
          name = "nix-pkgs-fmt";
          runtimeInputs = [
            pkgs.fd
            pkgs.nixfmt
          ];
          text = ''
            if [ "$#" -gt 0 ]; then
              exec nixfmt "$@"
            fi

            fd --extension nix --exec nixfmt {}
          '';
        }
      );
    };
}
