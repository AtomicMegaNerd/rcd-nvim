vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/esmuellert/codediff.nvim",
  "https://github.com/NeogitOrg/neogit",
})

require("neogit").setup({
  kind = "replace",
  graph_style = "unicode",
  integrations = {
    codediff = true,
    mini_pick = true,
  },
})

vim.keymap.set("n", "<leader>ng", function()
  require("neogit").open()
end, { desc = "Open [N]eo[G]it" })
