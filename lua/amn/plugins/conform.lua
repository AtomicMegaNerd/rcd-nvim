return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      lua = { "stylua" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
