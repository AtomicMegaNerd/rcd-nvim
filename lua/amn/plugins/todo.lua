return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>fT", "<cmd>TodoFzfLua<CR>", desc = "[F]ind [T]odos" },
  },
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup()
  end,
}
