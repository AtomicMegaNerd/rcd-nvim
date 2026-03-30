return {
  "NeogitOrg/neogit",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  opts = {
    kind = "replace",
    graph_style = "unicode",
    integrations = {
      diffview = true,
      snacks = true,
    },
  },
  keys = {
    {
      "<leader>ng",
      function()
        require("neogit").open()
      end,
      desc = "Open [N]eo[G]it",
    },
  },
}
