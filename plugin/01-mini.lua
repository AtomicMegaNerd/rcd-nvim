vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- The plugin and their config functions live here...
local mini_plugins = {
  -- Please keep these plugins in alphabetic order

  -- extended text objects: af/if (function), ac/ic (class) via treesitter
  ["mini.ai"] = function(m)
    m.setup({
      custom_textobjects = {
        f = m.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = m.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
      },
    })
  end,

  -- animations for cursor, scroll, resize, and window open/close
  ["mini.animate"] = function(m)
    m.setup()
  end,

  -- navigate jumps with [ and ] (buffers, diagnostics, hunks, etc.)
  ["mini.bracketed"] = function(m)
    m.setup()
  end,

  -- keymap hints popup (which-key alternative)
  ["mini.clue"] = function(m)
    m.setup({
      triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "t" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },
      clues = {
        m.gen_clues.g(),
        m.gen_clues.marks(),
        m.gen_clues.registers(),
        m.gen_clues.windows(),
        m.gen_clues.z(),
      },
    })
  end,

  -- make the nvim cmdline better
  ["mini.cmdline"] = function(m)
    m.setup()
  end,

  -- gc to toggle comments (line and block)
  ["mini.comment"] = function(m)
    m.setup()
  end,

  ["mini.completion"] = function(m)
    m.setup({
      lsp_completion = {
        snippet_insert = nil,
      },
    })
  end,

  -- git diff signs in the gutter with hunk navigation
  ["mini.diff"] = function(m)
    m.setup()
  end,

  -- extra pickers for mini.pick (LSP, git, files, etc.)
  ["mini.extra"] = function(m)
    m.setup()
  end,

  -- inline hex color previews (like nvim-colorizer)
  ["mini.hipatterns"] = function(m)
    m.setup({
      highlighters = {
        hex_color = m.gen_highlighter.hex_color(),
      },
    })
  end,

  -- icons with nvim-web-devicons compatibility shim
  ["mini.icons"] = function(m)
    m.setup()
    m.mock_nvim_web_devicons()
  end,

  -- animated indent scope line for the current block
  ["mini.indentscope"] = function(m)
    m.setup()
  end,

  -- move lines and selections with Alt+hjkl
  ["mini.move"] = function(m)
    m.setup()
  end,

  ["mini.notify"] = function(m)
    m.setup()
  end,

  -- extra operators: gs (sort), gm (duplicate), gx (exchange)
  ["mini.operators"] = function(m)
    m.setup()
  end,

  ["mini.pick"] = function(m)
    m.setup({})
  end,

  -- sa/sd/sr to add, delete, replace surrounding characters
  ["mini.surround"] = function(m)
    m.setup()
  end,

  ["mini.starter"] = function(m)
    m.setup()
  end,

  -- minimal status line
  ["mini.statusline"] = function(m)
    m.setup()
  end,
}

-- Iterate over each mini plugin and run setup() on it
for plugin_str, plugin_fn in pairs(mini_plugins) do
  local plugin = require(plugin_str)
  plugin_fn(plugin)
end

local pick = require("mini.pick")
local extra = require("mini.extra")

local map = vim.keymap.set

-- Files
map("n", "<leader>ff", function()
  pick.registry.files()
end, { desc = "[F]ind [F]iles" })
map("n", "<leader>fb", function()
  pick.builtin.buffers()
end, { desc = "[F]ind [B]uffers" })
map("n", "<leader>fl", function()
  pick.registry.grep_live()
end, { desc = "[F]ind [L]ive grep" })
map("n", "<leader>fh", function()
  pick.builtin.help()
end, { desc = "[F]ind [H]elp tags" })

-- LSP
map("n", "<leader>fs", function()
  extra.pickers.lsp({ scope = "document_symbol" })
end, { desc = "[F]ind [S]ymbols" })
map("n", "<leader>fw", function()
  extra.pickers.lsp({ scope = "workspace_symbol" })
end, { desc = "[F]ind [W]orkspace symbols" })

-- Diagnostics
map("n", "<leader>fd", function()
  extra.pickers.diagnostic({ scope = "current" })
end, { desc = "[F]ind Document [d]iagnostics" })
map("n", "<leader>fD", function()
  extra.pickers.diagnostic({ scope = "all" })
end, { desc = "[F]ind Workspace [D]iagnostics" })

-- Lists / other
map("n", "<leader>fq", function()
  extra.pickers.list({ scope = "quickfix" })
end, { desc = "[F]ind [Q]uickfix" })
map("n", "<leader>fk", function()
  extra.pickers.keymaps()
end, { desc = "[F]ind [K]eymaps" })

-- Git
map("n", "<leader>fgf", function()
  extra.pickers.git_files()
end, { desc = "[F]ind [G]it [F]iles" })
map("n", "<leader>fgc", function()
  extra.pickers.git_commits()
end, { desc = "[F]ind [G]it [C]ommits" })
map("n", "<leader>fgb", function()
  extra.pickers.git_branches()
end, { desc = "[F]ind [G]it [B]ranches" })
