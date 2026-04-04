require("nvim-treesitter").setup({})

local langs = {
  "bash",
  "go",
  "gomod",
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
  "rust",
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

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})
