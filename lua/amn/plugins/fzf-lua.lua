return {
  "ibhagwan/fzf-lua",

  keys = {
    -- Files
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "[F]ind [F]iles",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "[F]ind [B]uffers",
    },
    {
      "<leader>fl",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "[F]ind [L]ive grep",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "[F]ind [H]elp tags",
    },

    -- LSP
    {
      "<leader>fs",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "[F]ind [S]ymbols",
    },
    {
      "<leader>fw",
      function()
        require("fzf-lua").lsp_workspace_symbols()
      end,
      desc = "[F]ind [W]orkspace symbols",
    },

    -- Diagnostics
    {
      "<leader>fd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "[F]ind Document [d]iagnostics",
    },
    {
      "<leader>fD",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "[F]ind Workspace [D]iagnostics",
    },

    -- Quickfix / keymaps
    {
      "<leader>fq",
      function()
        require("fzf-lua").quickfix()
      end,
      desc = "[F]ind [Q]uickfix",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "[F]ind [K]eymaps",
    },

    -- Git
    {
      "<leader>fgf",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "[F]ind [G]it [F]iles",
    },
    {
      "<leader>fgc",
      function()
        require("fzf-lua").git_commits()
      end,
      desc = "[F]ind [G]it [C]ommits",
    },
    {
      "<leader>fgb",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "[F]ind [G]it [B]ranches",
    },

    -- Todos (requires todo-comments.nvim)
    { "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "[F]ind [T]odos" },
  },

  config = function()
    local yank = {
      function(selected)
        vim.fn.setreg("+", selected[1])
      end,
      noclose = true,
    }

    local fzf_lua = require("fzf-lua")
    fzf_lua.setup("telescope", {
      files = { hidden = true, actions = { ["ctrl-y"] = yank } },
      grep = { hidden = true, actions = { ["ctrl-y"] = yank } },
    })
    fzf_lua.register_ui_select()
  end,
}
