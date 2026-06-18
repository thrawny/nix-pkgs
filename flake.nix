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
          firecrawl-cli = pkgs.callPackage ./packages/firecrawl-cli/package.nix { };
          t3code = pkgs.callPackage ./packages/t3code/package.nix { };

          t3 = t3code;
          default = t3code;
        }
      );

      overlays.default = final: _prev: {
        firecrawl-cli = final.callPackage ./packages/firecrawl-cli/package.nix { };
        t3code = final.callPackage ./packages/t3code/package.nix { };
        t3 = final.t3code;
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
