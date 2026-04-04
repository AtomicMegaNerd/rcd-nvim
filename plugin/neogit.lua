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
