# Neovim config

This is a neovim config that can both be cloned onto a non-nix machine (work) and used as a flake
on my nix managed machines at home.


## Nix Setup

The flake uses nix-direnv. Our `.envrc` file will automatically setup our dev shell when we enter
the directory. The file needs to include:

```bash
use flake;
```

After editing this file we need to run the following to allow the flake to run:

```bash
direnv allow
```

## Current Neovim Version

We are running Neovim 0.11.x. Please consult online sources and neovim help pages for up-to-date
information on this version.

## Structure

```text
├── flake.lock
├── flake.nix # For nix systems
├── init.lua # The init file
├── lua
│   └── amn
│       ├── plugins # One file per plug-in all loaded with lazy.nvim
│       ├── user
│       │   ├── autocmds.lua
│       │   ├── keymap.lua
│       │   ├── options.lua
│       │   └── plugins.lua # Sets up lazy.nvim3
├── README.md
├── scripts
│   └── zellij.sh # A script to use my custom Zellij layout for this repo
└── stylua.toml
```

## Notes for the LLM

- The LLM is not allowed to edit this `AGENTS.md` file.
- No vimscript plug-ins if there is a lua alternative.
- We use modern Neovim API's and features as much as possible.
- We use lazy-loading when possible.
- Catppuccin is our theme, we may change the flavour from time to time.
- We use `lua-language-server` and `stylua` in this project.
- The flake sets up pre-commit with nix.
- We also install node in this environment so that MCP works with Claude Code.
- We install `nodejs-slim_24` for neovim as it doesn't need the npm tooling as we setup LSP's with
  nix.
- However, claude code doesn't use nix so for the devShell we install the full `nodejs` when doing
  development on this config.
- We only need to support `x86_64-linux` and `aarch64-darwin`.
- Use `bat`, `ripgrep`, and `fd` as I gave you permissions to use those.
