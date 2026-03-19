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

    require("nvim-treesitter.configs").setup({
      ensure_installed = langs,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
