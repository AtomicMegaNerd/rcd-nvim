# AtomicMegaNerd Neovim Configuration

![AtomicMegaNerd](https://github.com/AtomicMegaNerd/AtomicMegaNerd/blob/main/img/RCD-AtomicMegaNerd-Beard-400.png)

This repo is my [Neovim](https://neovim.io) configuration.

## Deployment on Nix Systems

See my flake: [dotfiles](https://github.com/AtomicMegaNerd/dotfiles/).

My **home-manager** configuration for that repo will automatically clone this repo in `~/.config`. The instructions for setting that up are in the repo.

## Deployment on Non-nix Systems

For non-nix system we use [mise-en-place](https://mise.jdx.dev/). Please install it before cloning this repo.

Clone directly to `~/.config/nvim`:

```sh
git clone git@github.com:AtomicMegaNerd/rcd-nvim ~/.config/nvim
```

Then enable mise:

```sh
mise trust .
mise install
mise setup
```

The last command will setup pre-commit on the non-nix system.

## Plugin Management

Plugins are managed with Neovim's built-in `vim.pack` . All plugins are _imported_ in `lua/pack.lua` and are _configured_ in the `plugin` directory (1 file per plugin).

See [echasnovski blog post](https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html).

### Updating plugins

After opening Neovim run this in **Command** mode:

```vim
:lua vim.pack.update()
```

This opens a confirmation buffer showing what will change. Write the buffer to confirm, or close it to cancel. I actually mapped `<leader>pu` to this function to update plug-ins.

### Removing a plugin

1. Remove the entry from `lua/pack.lua`
2. Delete it from disk:

Again run the following in **Command** mode:

```lua
:lua vim.pack.del({ 'plugin-name' })
```

Do not delete plugin directories manually — this leaves the lockfile out of sync and causes reinstallation on next startup.

## More Information

See [AGENTS.md](AGENTS.md).
