return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      auto_integrations = true,
      flavour = "macchiato",
      no_italic = true,
      transparent_background = true,
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
