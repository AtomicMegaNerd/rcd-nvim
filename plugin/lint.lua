vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

require("lint").linters_by_ft = {
  go = { "golangcilint" },
  yaml = { "yamllint" },
  md = { "markdownlint-cli2" },
  html = { "htmlhint" },
}
