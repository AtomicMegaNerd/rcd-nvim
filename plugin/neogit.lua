local neogit = require("neogit")
neogit.setup({
  integrations = {
    codediff = true,
    fzf_lua = true,
  },
  graph_style = "unicode",
  process_spinner = true,
})

vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Neo[G]it [G]it" })
