return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<leader>o", "<Cmd>Oil<CR>", desc = "Open current directory in Oil" },
  },
  opts = {
    columns = {
      "icon",
      "size",
      "mtime",
    },
    view_options = {
      show_hidden = true,
    },
  },
}
