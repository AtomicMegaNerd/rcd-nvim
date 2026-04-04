require("catppuccin").setup({
  no_italic = true,
  flavour = "macchiato",

  integrations = {
    diffview = true,
    neogit = true,
    notify = true,
    mini = {
      enabled = true,
    },
    blink_cmp = {
      style = "bordered",
    },
    fzf = true,
  },
})

-- Set the colorscheme
vim.cmd.colorscheme("catppuccin-nvim")
