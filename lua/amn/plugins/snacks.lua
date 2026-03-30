return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Keep these in alphabetical order please

    -- pretty start screen with recent files and keymaps
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        { section = "startup" },
      },
    },

    -- better vim.ui.input (used by LSP rename, etc.)
    input = { enabled = true },

    -- notification history and LSP progress messages
    notifier = { enabled = true },

    -- fuzzy picker for files, grep, LSP, git, and more
    picker = {
      enabled = true,
      layout = { preset = "telescope", reverse = false },
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
      },
      win = {
        input = {
          keys = {
            ["<C-y>"] = { "yank", mode = { "i", "n" } },
          },
        },
      },
    },

    -- fast buffer loading for large files by skipping expensive plugins
    quickfile = { enabled = true },

    -- file rename on disk with LSP import updates (integrates with mini.files)
    rename = { enabled = true },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)

    if opts.input and opts.input.enabled then
      vim.ui.input = snacks.input.input
    end

    local map = vim.keymap.set
    local p = snacks.picker

    -- Files
    map("n", "<leader>ff", p.files, { desc = "[F]ind [F]iles" })
    map("n", "<leader>fb", p.buffers, { desc = "[F]ind [B]uffers" })
    map("n", "<leader>fl", p.grep, { desc = "[F]ind [L]ive grep" })
    map("n", "<leader>fh", p.help, { desc = "[F]ind [H]elp tags" })

    -- LSP
    map("n", "<leader>fs", p.lsp_symbols, { desc = "[F]ind [S]ymbols" })
    map("n", "<leader>fw", p.lsp_workspace_symbols, { desc = "[F]ind [W]orkspace symbols" })
    map("n", "<leader>fr", p.lsp_references, { desc = "[F]ind [R]eferences" })

    -- Diagnostics
    map("n", "<leader>fd", p.diagnostics_buffer, { desc = "[F]ind Document [d]iagnostics" })
    map("n", "<leader>fD", p.diagnostics, { desc = "[F]ind Workspace [D]iagnostics" })

    -- Quickfix / keymaps
    map("n", "<leader>fq", p.qflist, { desc = "[F]ind [Q]uickfix" })
    map("n", "<leader>fk", p.keymaps, { desc = "[F]ind [K]eymaps" })

    -- Git
    map("n", "<leader>fgf", p.git_files, { desc = "[F]ind [G]it files" })
    map("n", "<leader>fgc", p.git_log, { desc = "[F]ind [G]it [C]ommits" })
    map("n", "<leader>fgb", p.git_branches, { desc = "[F]ind [G]it [B]ranches" })

    -- Notifications
    map("n", "<leader>fn", p.notifications, { desc = "[F]ind past [N]otifications" })
  end,
}
