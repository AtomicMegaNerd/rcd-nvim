{
  description = "AtomicMegaNerd's Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, git-hooks }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      buildPreCommitCheck =
        system:
        git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            trim-trailing-whitespace.enable = true;
            mixed-line-endings.enable = true;
            end-of-file-fixer.enable = true;
            check-toml.enable = true;
            stylua.enable = true;
          };
        };
    in
    {
      homeManagerModules.default =
        { pkgs, ... }:
        {
          programs.neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
            extraPackages = with pkgs; [
              gcc
              tree-sitter
              nodejs-slim_24
            ];
          };
          xdg.configFile."nvim".source = self;
        };

      checks = forAllSystems (system: {
        pre-commit-check = buildPreCommitCheck system;
      });

      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs = [
              pkgs.nodejs-slim_24 # Needed for claude to use MCP
            ];
          };
        }
      );
    };
}
