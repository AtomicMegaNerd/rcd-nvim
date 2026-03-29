return {
  "andythigpen/nvim-coverage",
  version = "*",
  lazy = false,
  keys = {
    {
      "<leader>va",
      function()
        require("coverage").load(true)
      end,
      desc = "Co[V]erage lo[A]d and show",
    },
    {
      "<leader>vl",
      function()
        require("coverage").load()
      end,
      desc = "Co[V]erage [L]oad",
    },
    {
      "<leader>vi",
      function()
        require("coverage").load_lcov()
      end,
      desc = "Co[V]erage lcov [I]mport",
    },
    {
      "<leader>vo",
      function()
        require("coverage").show()
      end,
      desc = "Co[V]erage sh[O]w",
    },
    {
      "<leader>vh",
      function()
        require("coverage").hide()
      end,
      desc = "Co[V]erage [H]ide",
    },
    {
      "<leader>vt",
      function()
        require("coverage").toggle()
      end,
      desc = "Co[V]erage [T]oggle",
    },
    {
      "<leader>vc",
      function()
        require("coverage").clear()
      end,
      desc = "Co[V]erage [C]lear",
    },
    {
      "<leader>vs",
      function()
        require("coverage").summary()
      end,
      desc = "Co[V]erage [S]ummary",
    },
  },

  config = function()
    local coverage = require("coverage")

    coverage.setup({
      auto_reload = true,
      load_coverage_cb = function(ftype)
        vim.notify("Loaded " .. ftype .. " coverage")
      end,
      lang = {
        go = {
          coverage_file = "cover.out",
        },
      },
    })

    local coverage_group = vim.api.nvim_create_augroup("amn-coverage", { clear = true })
    local coverage_files = { go = "cover.out", python = ".coverage" }
    vim.api.nvim_create_autocmd("FileType", {
      group = coverage_group,
      pattern = { "go", "python" },
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        local cov_file = coverage_files[ft]
        if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. cov_file) == 1 then
          coverage.load()
          coverage.show()
        end
      end,
      desc = "Load and show coverage for Go and Python buffers",
    })
  end,
}
