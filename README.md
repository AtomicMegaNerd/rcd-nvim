# rcd-nvim

```text
    ___   __                  _      __  ___                 _   __              __
   /   | / /_____  ____ ___  (_)____/  |/  /__  ____ _____ _/ | / /__  _________/ /
  / /| |/ __/ __ \/ __ `__ \/ / ___/ /|_/ / _ \/ __ `/ __ `/  |/ / _ \/ ___/ __  /
 / ___ / /_/ /_/ / / / / / / / /__/ /  / /  __/ /_/ / /_/ / /|  /  __/ /  / /_/ /
/_/  |_\__/\____/_/ /_/ /_/_/\___/_/  /_/\___/\__, /\__,_/_/ |_/\___/_/   \__,_/
                                             /____/
```

![AtomicMegaNerd](https://github.com/AtomicMegaNerd/AtomicMegaNerd/blob/main/img/RCD-AtomicMegaNerd-Beard-400.png)

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

## Zellij

A Zellij layout and helper script are included for working on this config:

```sh
bash scripts/zellij.sh
```
