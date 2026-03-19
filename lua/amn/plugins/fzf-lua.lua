return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
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
    {
      "<leader>fl",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "[F]ind [L]ive grep",
    },
    {
      "<leader>fq",
      function()
        require("fzf-lua").quickfix()
      end,
      desc = "[F]ind [Q]uickfix",
    },
    -- Git
    {
      "<leader>fgf",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "[F]ind [G]it files",
    },
    {
      "<leader>fgs",
      function()
        require("fzf-lua").git_status()
      end,
      desc = "[F]ind [G]it [S]tatus",
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
    -- General
    {
      "<leader>fh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "[F]ind [H]elp tags",
    },
    {
      "<leader>fc",
      function()
        require("fzf-lua").commands()
      end,
      desc = "[F]ind [C]ommands",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "[F]ind [K]eymaps",
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
    {
      "<leader>fr",
      function()
        require("fzf-lua").lsp_references()
      end,
      desc = "[F]ind [R]eferences",
    },
  },
  config = function()
    -- Use fzf-lua as the default UI selector
    require("fzf-lua").register_ui_select()
    require("fzf-lua").setup({
      file_ignore_patterns = {
        "node_modules/",
        "**/__pycache__",
        "__pycache__",
        ".pytest_cache",
        ".venv",
      },
    })
  end,
}
