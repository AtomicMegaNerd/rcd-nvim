require("catppuccin").setup({
  flavour = "macchiato",
  no_italic = false,

  integrations = {
    grug_far = true,
    overseer = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin-nvim")
