local neogit = require("neogit")
neogit.setup({
  graph_style = "unicode",
  integrations = {
    codediff = true,
    mini_pick = true,
  },
  popup = {
    kind = "floating",
  },
})

-- Basic interface
vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Neo[G]it [G]it" })

vim.keymap.set("n", "<leader>gb", function()
  neogit.open({ "branch" })
end, { desc = "Neo[G]it [B]ranch" })

vim.keymap.set("n", "<leader>gw", function()
  neogit.open({ "worktree" })
end, { desc = "Neo[G]it [W]worktree" })

vim.keymap.set("n", "<leader>gP", function()
  neogit.open({ "push" })
end, { desc = "Neo[G]it [P]ush" })

vim.keymap.set("n", "<leader>gp", function()
  neogit.open({ "pull" })
end, { desc = "Neo[G]it [P]ull" })
