return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  keys = {
    {
      "<leader>gg",
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
      -- Never use tabs
      kind = "replace",
      graph_style = "unicode",
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
      commit_editor = {
        kind = "replace",
        staged_diff_split_kind = "auto",
      },
    })
  end,
}
