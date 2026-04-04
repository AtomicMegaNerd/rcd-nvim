vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

require("lint").linters_by_ft = {
  go = { "golangcilint" },
  yaml = { "yamllint" },
  markdown = { "markdownlint-cli2" },
  html = { "htmlhint" },
}
