return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  config = function()
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

    require("nvim-treesitter").setup({
      ensure_installed = langs,
      auto_install = true,
    })
  end,
}
