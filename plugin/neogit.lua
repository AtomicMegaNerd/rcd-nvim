local neogit = require("neogit")
neogit.setup({
  integrations = {
    codediff = true,
    fzf_lua = true,
  },
  graph_style = "unicode",
  process_spinner = true,
  commit_editor = {
    kind = "floating",
  },
  commit_select_view = {
    kind = "floating",
  },
  commit_view = {
    kind = "vsplit",
  },
  log_view = {
    kind = "floating",
  },
  rebase_editor = {
    kind = "auto",
  },
  reflog_view = {
    kind = "floating",
  },
  merge_editor = {
    kind = "auto",
  },
  preview_buffer = {
    kind = "floating_console",
  },
  popup = {
    kind = "split",
  },
  stash = {
    kind = "floating",
  },
  refs_view = {
    kind = "floating",
  },
})

vim.keymap.set("n", "<leader>gg", function()
  neogit.open({ kind = "floating" })
end, { desc = "Neo[G]it [G]it" })
