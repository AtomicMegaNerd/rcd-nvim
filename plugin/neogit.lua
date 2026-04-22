local neogit = require("neogit")
neogit.setup({
  integrations = {
    codediff = true,
    fzf_lua = true,
  },
  graph_style = "unicode",
  process_spinner = true,
  commit_editor = {
    kind = "replace",
  },
  commit_select_view = {
    kind = "replace",
  },
  commit_view = {
    kind = "vsplit",
  },
  log_view = {
    kind = "replace",
  },
  rebase_editor = {
    kind = "auto",
  },
  reflog_view = {
    kind = "replace",
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
    kind = "replace",
  },
  refs_view = {
    kind = "replace",
  },
})

vim.keymap.set("n", "<leader>gg", function()
  neogit.open({ kind = "replace" })
end, { desc = "Neo[G]it [G]it" })
