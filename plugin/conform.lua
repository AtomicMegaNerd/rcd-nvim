require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "oxfmt" },
    go = { "goimports", "golines" },
  },
  format_on_save = { timeout_ms = 1000, lsp_format = "fallback", quiet = true },
})
