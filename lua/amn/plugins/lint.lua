return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      go = { "golangcilint" },
      yaml = { "yamllint" },
      md = { "markdownlint-cli2" },
      html = { "htmlhint" },
    }
  end,
}
