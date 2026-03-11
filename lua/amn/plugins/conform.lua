return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local utils = require("amn.utils")
    local conform = utils.do_import("conform")
    if not conform then
      return
    end
    conform.setup({
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
    })
  end,
}
