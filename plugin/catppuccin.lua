require("catppuccin").setup({
  flavour = "latte",
  no_italic = true,

  integrations = {
    grug_far = true,
    overseer = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin-nvim")
