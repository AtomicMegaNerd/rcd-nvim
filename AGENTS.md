# Neovim config

This is a neovim config that can both be cloned onto a non-nix machine (work) and used as a flake
on my nix managed machines at home.

## Current Neovim Version

We are running Neovim 0.11.x. Please consult online sources and neovim help pages for up-to-date
information on this version.

## Structure

```text
❯ tree
.
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
│       └── utils.lua
├── README.md
├── scripts
│   └── zellij.sh # A script to use my custom Zellij layout for this repo
└── stylua.toml
```

## Notes for the LLM

- The LLM is not allowed to edit this AGENTS.md file.
- No vimscript plug-ins if there is a lua alternative.
- We use modern Neovim API's and features as much as possible.
- We use lazy-loading when possible.
- Catppuccin is our theme, we may change the flavour from time to time.
- We have custom key-mapping and require loading helper functions in `lua/amn/utils.lua`. We always
  use these.
- We use lua-language-server and styla in this project.


