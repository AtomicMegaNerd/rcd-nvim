{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix.url = "github:nix-community/fenix";
  };

  outputs =
    {
      self,
      nixpkgs,
      git-hooks,
      fenix,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
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
              oxfmt = {
                enable = true;
                name = "oxfmt";
                entry = "oxfmt .";
                pass_filenames = false;
              };
              stylua.enable = true;
              # We need to tell lua-ls where the neovim runtime libraries are on
              # Nix systems
              lua-ls = {
                enable = true;
                settings.configuration = {
                  runtime.version = "LuaJIT";
                  workspace = {
                    checkThirdParty = false;
                    library = [
                      "${pkgs.neovim-unwrapped}/share/nvim/runtime/lua"
                    ];
                  };
                };
              };
              markdownlint.enable = true;
              trim-trailing-whitespace.enable = true;
              mixed-line-endings.enable = true;
              end-of-file-fixer.enable = true;
              nixfmt.enable = true;
              flake-checker.enable = true;
            };
          };
        }
      );

      devShells = forAllSystems (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            toolchain = fenix.packages.${system}.stable.toolchain;
            rust-analyzer = fenix.packages.${system}.stable.rust-analyzer;
          in
          pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            packages = [
              pkgs.stylua
              pkgs.lua-language-server
              pkgs.markdownlint-cli2
              pkgs.nixfmt
              pkgs.nil
              pkgs.oxfmt
              pkgs.libiconv
              # Added Rust to build blink.cmp native fuzzy library
              toolchain
              rust-analyzer
            ];
            RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
          };
      });
    };
}
