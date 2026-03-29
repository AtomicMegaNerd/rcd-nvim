return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        { section = "startup" },
      },
    },
  },
  keys = {
    {
      "<leader>n",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "[N]otification history",
    },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)
    if opts.input and opts.input.enabled then
      vim.ui.input = snacks.input.input
    end
  end,
}
