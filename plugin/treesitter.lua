vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter").setup({
  additional_vim_regex_highlighting = false,
})

local langs = {
  "bash",
  "go",
  "json",
  "lua",
  "markdown",
  "python",
  "sql",
  "vim",
  "yaml",
  "toml",
  "nix",
  "diff",
  "gomod",
  "fish",
  "html",
  "css",
}

require("nvim-treesitter").install(langs)
local trs_grp = vim.api.nvim_create_augroup("Treesitter", { clear = true })
for _, lang in ipairs(langs) do
  vim.api.nvim_create_autocmd("FileType", {
    group = trs_grp,
    pattern = lang,
    callback = function()
      vim.treesitter.start()
    end,
  })
end
