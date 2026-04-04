vim.pack.add({ "stevearc/oil.nvim" })

require("oil").setup({
  columns = {
    "icon",
    "size",
    "mtime",
  },
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "<leader>o", "<Cmd>Oil<CR>", { desc = "Open current directory in Oil" })
