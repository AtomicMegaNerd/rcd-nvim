return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local langs = {
      "bash",
      "dockerfile",
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

    require("nvim-treesitter").install(langs):wait(300000)

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
  end,
}
