{
  description = "Neovim config";

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

      # TODO: Add Rust tooling to this devShell so we can build the blink.cmp native code
      devShells = forAllSystems (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
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
            ];
          };
      });
    };
}
