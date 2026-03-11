# rcd-nvim

AtomicMegaNerd's Neovim configuration.

## Usage

### With Nix (home-manager)

Add as a flake input:

```nix
rcd-nvim.url = "github:AtomicMegaNerd/rcd-nvim";
```

Then import the module in your home-manager configuration:

```nix
imports = [ inputs.rcd-nvim.homeManagerModules.default ];
```

This sets up `programs.neovim` and links the config to `~/.config/nvim`.

### Without Nix

Clone directly to `~/.config/nvim`:

```sh
git clone git@github.com:AtomicMegaNerd/rcd-nvim ~/.config/nvim
```

## Development

Enter the dev shell to activate pre-commit hooks:

```sh
nix develop
```

## Zellij

A Zellij layout and helper script are included for working on this config:

```sh
bash scripts/rcd-nvim.sh
```
