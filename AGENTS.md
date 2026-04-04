# Neovim config

This is a neovim config that can both be cloned onto a non-nix machine (work) and used as a flake
on my nix managed machines at home.

## Current Neovim Version

**We are running Neovim 0.12**. Please consult online sources and neovim help pages for up-to-date
information on this version. Do not rely on training data which will likely refer to older releases
which are out of date.

## Structure

```text
  ├── init.lua # The init file, this is the entry point
  ├── lua
  │   ├── options.lua # vim options
  │   ├── pack.lua # plugin registration via vim.pack
  │   ├── autocmds.lua # autocommands
  │   ├── keymap.lua # keymaps
  │   └── lsp.lua # global LSP setup and capabilities
  ├── plugin # Plugin configurations, will auto-load after init
  ├── lsp # LSP server configs, auto-loaded lazily when clients start
  ├── AGENTS.md # Instructions for LLM's
  ├── README.md # Instructions for humans
  ├── stylua.toml # Lua formatter config
  ├── .markdownlint.json # Markdown lint config
  ├── flake.nix
  ├── .envrc # Enables direnv with this flake
  └── nvim-pack-lock.json # Lock file for nvim pack
```

### Load Order

  1. `init.lua` — entry point, explicitly loads its imports in order from `lua/`.
  2. `plugin/` — auto-loaded by Neovim after init (runtime scan).
  3. `lsp/` — auto-loaded lazily by Neovim's built-in LSP system when clients start.

## Notes for LLM

- The flake in this repo is just for setting up `pre-commit`.
- The LLM is not allowed to edit this `AGENTS.md` file.
- Never use vimscript if we can use lua.
- We use modern Neovim API's and features as much as possible.
- We use the built-in `vim.pack` package manager.
- Catppuccin is our theme, we may change the flavour from time to time.
- Use github and context7 MCP servers when doing queries where it makes sense.
- Run `pre-commit run` to run the linters against the repo after making changes.
- Running `direnv allow` allows the flake to auto-load when entering the directory.
- We put all plug-in registrations in `lua/pack.lua` to ensure that the plug-ins are added
  in the right order and so we never need duplicates.
- Plug-in configuration happens separately in the `plugin/` directory.
