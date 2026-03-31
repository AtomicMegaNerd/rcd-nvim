return {
  "NeogitOrg/neogit",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "esmuellert/codediff.nvim",
  },
  opts = {
    kind = "replace",
    graph_style = "unicode",
    integrations = {
      codediff = true,
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
