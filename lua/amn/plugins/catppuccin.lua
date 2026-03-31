return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
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
  },
}
