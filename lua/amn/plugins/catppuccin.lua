return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      flavour = "macchiato",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      no_italic = true,
      integrations = {
        snacks = {
          enabled = true,
        },
        mini = {
          enabled = true,
        },
        diffview = {
          enable = true,
        },
        blink_cmp = {
          enabled = true,
        },
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
