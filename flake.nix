{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    fenix.url = "github:nix-community/fenix";
  };

  outputs =
    {
      self,
      nixpkgs,
      fenix,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            toolchain = fenix.packages.${system}.stable.withComponents [
              "cargo"
              "rustc"
            ];
          in
          pkgs.mkShell {
            packages = [
              pkgs.stylua
              pkgs.lua-language-server
              # Added Rust to build blink.cmp native fuzzy library
              toolchain
            ];
          };
      });
    };
}
