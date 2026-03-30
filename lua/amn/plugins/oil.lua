return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<leader>o", "<Cmd>Oil<CR>", desc = "Open current directory in Oil" },
  },
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        for _, action in ipairs(event.data.actions) do
          if action.type == "move" then
            Snacks.rename.on_rename_file(action.src_url, action.dest_url)
          end
        end
      end,
    })

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
  end,
}
