vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
require("catppuccin").setup({
  no_italic = true,
  flavour = "macchiato",

  integrations = {
    diffview = true,
    neogit = true,
    notify = true,
    snacks = {
      enabled = true,
    },
    mini = {
      enabled = true,
    },
    blink_cmp = {
      style = "bordered",
    },
  },
})

-- Set the colorscheme
vim.cmd.colorscheme("catppuccin-nvim")
