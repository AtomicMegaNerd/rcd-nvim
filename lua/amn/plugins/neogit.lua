return {
  "NeogitOrg/neogit",
  version = false,
  keys = {
    {
      "<leader>ng",
      function()
        require("neogit").open()
      end,
      desc = "Open [N]eo[G]it",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
  },
  config = function()
    require("neogit").setup({
      kind = "replace",
      graph_style = "unicode",
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
      commit_editor = {
        kind = "replace",
      },
    })
  end,
}
