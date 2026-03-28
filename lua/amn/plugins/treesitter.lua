return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter")
      .install({
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
      })
      :wait(300000)
  end,
}
