return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fredrikaverpil/neotest-golang",
    "nvim-neotest/neotest-python",
  },
  keys = {
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.uv.cwd())
        require("neotest").summary.open()
        require("neotest").output_panel.toggle()
      end,
      desc = "[T]est run [A]ll",
    },
    {
      "<leader>tc",
      function()
        require("neotest").run.run()
      end,
      desc = "[T]est run under [C]ursor",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "[T]est run [F]ile",
    },
    {
      "<leader>tp",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "[T]est output [P]anel",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "[T]est [S]ummary",
    },
    {
      "<leader>tq",
      function()
        require("neotest").run.stop()
      end,
      desc = "[T]est stop/[Q]uit",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang")({
          go_test_args = function()
            return {
              "-v",
              "-race",
              "-count=1",
              "-coverprofile=cover.out",
            }
          end,
        }),
        require("neotest-python")({}),
      },
    })
  end,
}
