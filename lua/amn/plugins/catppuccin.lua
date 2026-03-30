return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      auto_integrations = true,
      no_italic = true,
      flavour = "macchiato",
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
