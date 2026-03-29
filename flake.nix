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
        let
          # Temporary override to install neovim 0.12 which just shipped
          pkgs' = pkgs.extend (_final: prev: {
            neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (_: {
              version = "0.12.0";
              src = prev.fetchFromGitHub {
                owner = "neovim";
                repo = "neovim";
                tag = "v0.12.0";
                hash = "sha256-uWhrGAwQ2nnAkyJ46qGkYxJ5K1jtyUIQOAVu3yTlquk=";
              };
            });
          });
        in
        {
          programs.neovim = {
            enable = true;
            package = pkgs'.neovim;
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
            buildInputs = with pkgs; [
              nodejs # Needed for claude to use MCP
            ];
          };
        }
      );
    };
}
