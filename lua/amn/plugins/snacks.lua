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
          cwd = true,
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
    -- (disabled in favor of fzf-lua — re-enable to evaluate)
    -- picker = {
    --   enabled = true,
    --   layout = { preset = "telescope", reverse = false },
    --   sources = {
    --     files = { hidden = true },
    --     grep = { hidden = true },
    --   },
    --   win = {
    --     input = {
    --       keys = {
    --         ["<C-y>"] = { "yank", mode = { "i", "n" } },
    --       },
    --     },
    --   },
    -- },

    -- file rename on disk with LSP import updates
    rename = { enabled = true },
  },
  -- (keys disabled in favor of fzf-lua — re-enable to evaluate)
  -- keys = {
  --   -- Files
  --   { "<leader>ff",  function() Snacks.picker.files() end,                    desc = "[F]ind [F]iles" },
  --   { "<leader>fb",  function() Snacks.picker.buffers() end,                  desc = "[F]ind [B]uffers" },
  --   { "<leader>fl",  function() Snacks.picker.grep() end,                     desc = "[F]ind [L]ive grep" },
  --   { "<leader>fh",  function() Snacks.picker.help() end,                     desc = "[F]ind [H]elp tags" },
  --   { "<leader>fs",  function() Snacks.picker.lsp_symbols() end,              desc = "[F]ind [S]ymbols" },
  --   { "<leader>fw",  function() Snacks.picker.lsp_workspace_symbols() end,    desc = "[F]ind [W]orkspace symbols" },
  --   { "<leader>fd",  function() Snacks.picker.diagnostics_buffer() end,       desc = "[F]ind Document [d]iagnostics" },
  --   { "<leader>fD",  function() Snacks.picker.diagnostics() end,              desc = "[F]ind Workspace [D]iagnostics" },
  --   { "<leader>fq",  function() Snacks.picker.qflist() end,                   desc = "[F]ind [Q]uickfix" },
  --   { "<leader>fk",  function() Snacks.picker.keymaps() end,                  desc = "[F]ind [K]eymaps" },
  --   { "<leader>fgf", function() Snacks.picker.git_files() end,                desc = "[F]ind [G]it [F]iles" },
  --   { "<leader>fgc", function() Snacks.picker.git_log() end,                  desc = "[F]ind [G]it [C]ommits" },
  --   { "<leader>fgb", function() Snacks.picker.git_branches() end,             desc = "[F]ind [G]it [B]ranches" },
  --   { "<leader>ft",  function() Snacks.picker.pick("todo_comments") end,      desc = "[F]ind [T]odos" },
  --   { "<leader>fn",  function() Snacks.picker.notifications() end,            desc = "[F]ind past [N]otifications" },
  -- },
}
