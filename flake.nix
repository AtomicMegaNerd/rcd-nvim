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
    {
      self,
      nixpkgs,
      git-hooks,
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
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
              copilot-language-server
              gcc
              nodejs-slim # Smaller nodejs for lsp's which don't need npm or npx
              tree-sitter
            ];
          };
          xdg.configFile."nvim".source = self;
        };

      checks = forAllSystems (system: {
        pre-commit-check = git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            trim-trailing-whitespace.enable = true;
            mixed-line-endings.enable = true;
            end-of-file-fixer.enable = true;
            check-toml.enable = true;
            stylua.enable = true;
          };
        };
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
