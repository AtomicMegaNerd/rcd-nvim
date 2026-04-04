# Neovim config

This is a neovim config that can both be cloned onto a non-nix machine (work) and used as a flake
on my nix managed machines at home.



## Current Neovim Version

We are running Neovim 0.12.x. Please consult online sources and neovim help pages for up-to-date
information on this version.

## Structure

```text
├── init.lua # The init file
├── lsp # LSP configurations
├── lua # Core Lua configurations
├── plugin # Plugin conigurations
├── README.md
├── scripts
│   └── zellij.sh # A script to use my custom Zellij layout for this repo
└── stylua.toml
```

## Notes for the LLM

- **CRITITAL**: It is __FAR__ better to say I don't know than waste my time with made up code.
- The LLM is not allowed to edit this `AGENTS.md` file.
- No vimscript plug-ins if there is a lua alternative.
- We use modern Neovim API's and features as much as possible.
- We use the built-in `vim.pack` package manager.
- Catppuccin is our theme, we may change the flavour from time to time.
