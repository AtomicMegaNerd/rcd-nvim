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

AtomicMegaNerd's [Neovim](https://neovim.io) configuration.

## Deployment on Nix Systems

See [https://github.com/AtomicMegaNerd/dotfiles/blob/main/nix/neovim.nix](https://github.com/AtomicMegaNerd/dotfiles/blob/main/nix/neovim.nix).

You just want home-manager to clone this repo to ~/.config/nvim in a way that keeps it mutable.

## Deployment on Non-nix Systems

Clone directly to `~/.config/nvim`:

```sh
git clone git@github.com:AtomicMegaNerd/rcd-nvim ~/.config/nvim
```

## Plugin Management

See [https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html](https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html).

Plugins are managed with Neovim's built-in `vim.pack` . All plugins are _imported_ in
`lua/pack.lua` and are _configured_ in the `plugin` directory (1 file per plugin).

### Updating plugins

```vim
:lua vim.pack.update()
```

This opens a confirmation buffer showing what will change. Write the buffer to confirm, or close
it to cancel.

### Removing a plugin

1. Remove the entry from `lua/pack.lua`
2. Delete it from disk:

```vim
:lua vim.pack.del({ 'plugin-name' })
```

Do not delete plugin directories manually — this leaves the lockfile out of sync and causes
reinstallation on next startup.

## More Information

See [AGENTS.md](AGENTS.md) for more information on the structure of this repo and how to work with
it.

## Q&A

### Why is This a Flake?

I always use Nix to configure pre-commit using [https://github.com/cachix/git-hooks.nix](https://github.com/cachix/git-hooks.nix).

This just makes it easy to keep pre-commit up-to-date and not letting pre-commit install packages
alongside my nix stuff.

To enable this flake to load automatically whenever you enter the directory run this command once
after cloning the repo:

```bash
direnv allow
```

If you are not on Nix you can 100% ignore the flake.

### Why is this not 100% Nix?

I use the same config at work which does not allow me to use Nix. Also I just want to use
the standard Neovim Lua plug-in ecosystem without relying on Nix as a middle-man. I change my
editor config a lot. This approach also means I don't have to run `nh home switch .` each
time I update my config.
