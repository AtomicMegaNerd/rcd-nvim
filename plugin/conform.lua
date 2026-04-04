require("conform").setup({
  formatters_by_ft = {
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    lua = { "stylua" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
