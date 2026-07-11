require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "oxfmt" },
    go = { "golines" },
  },
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})
