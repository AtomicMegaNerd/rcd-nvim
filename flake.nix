{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    fenix.url = "github:nix-community/fenix";
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      fenix,
      git-hooks,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          pre-commit-check = git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixfmt.enable = true;
              yaml-lint = {
                enable = true;
                name = "yaml lint";
                entry = "${pkgs.yamllint}/bin/yamllint --strict";
                language = "system";
                types = [ "yaml" ];
              };
              md-lint = {
                enable = true;
                name = "markdown lint";
                entry = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
                language = "system";
                types = [ "markdown" ];
              };
              md-format = {
                enable = true;
                name = "markdown format";
                entry = "${pkgs.oxfmt}/bin/oxfmt";
                language = "system";
                types = [ "markdown" ];
              };
              lua-format = {
                enable = true;
                name = "lua format";
                entry = "${pkgs.stylua}/bin/stylua";
                language = "system";
                types = [ "lua" ];
              };
            };
          };
        }
      );

      devShells = forAllSystems (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
            toolchain = fenix.packages.${system}.stable.withComponents [
              "cargo"
              "rustc"
            ];
          in
          pkgs.mkShell {
            inherit shellHook;
            VIMRUNTIME = "${pkgs.neovim-unwrapped}/share/nvim/runtime";
            packages = [
              pkgs.stylua
              pkgs.lua-language-server
              # Added Rust to build blink.cmp native fuzzy library
              toolchain
            ]
            ++ enabledPackages;
          };
      });
    };
}
