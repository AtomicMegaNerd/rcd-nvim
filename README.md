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

Clone directly to `~/.config/nvim`:

```sh
git clone git@github.com:AtomicMegaNerd/rcd-nvim ~/.config/nvim
```

## Zellij

A Zellij layout and helper script are included for working on this config:

```sh
bash scripts/zellij.sh
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
