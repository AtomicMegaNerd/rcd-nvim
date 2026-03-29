return {
  "nvim-mini/mini.nvim",
  version = false,

  config = function()
    -- The plugin and their config functions live here...
    local mini_plugins = {

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

      -- gc to toggle comments (line and block)
      ["mini.comment"] = function(m)
        m.setup()
      end,

      -- git diff signs in the gutter with hunk navigation
      ["mini.diff"] = function(m)
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

      -- extra operators: gs (sort), gm (duplicate), gx (exchange)
      ["mini.operators"] = function(m)
        m.setup()
      end,

      -- auto-close brackets and quotes
      ["mini.pairs"] = function(m)
        m.setup()
      end,

      -- sa/sd/sr to add, delete, replace surrounding characters
      ["mini.surround"] = function(m)
        m.setup()
      end,

      -- file explorer with editable buffers (oil alternative)
      ["mini.files"] = function(m)
        m.setup({
          options = {
            use_as_default_explorer = true,
          },
        })
        vim.keymap.set("n", "<leader>o", function()
          m.open(vim.api.nvim_buf_get_name(0))
        end, { desc = "Open current directory in mini.files" })
      end,

      -- notifications with history and LSP progress
      ["mini.notify"] = function(m)
        m.setup()
        vim.lsp.handlers["$/progress"] = m.lsp_progress_handler()
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
  end,
}
