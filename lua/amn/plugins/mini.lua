return {
  "nvim-mini/mini.nvim",
  version = false,

  config = function()
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

      -- extra pickers for mini.pick (diagnostics, lsp, git, etc.)
      ["mini.extra"] = function(m)
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

      -- notifications with history and LSP progress
      ["mini.notify"] = function(m)
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

      -- fuzzy picker (files, grep, buffers, help, etc.)
      ["mini.pick"] = function(m)
        m.setup({
          mappings = {
            yank_item = {
              char = "<C-y>",
              func = function()
                local item = m.get_picker_matches().current
                if item then
                  local text = type(item) == "string" and item or (item.text or vim.inspect(item))
                  vim.fn.setreg("+", text)
                  vim.notify("Yanked: " .. text)
                end
              end,
            },
          },
        })
        vim.ui.select = m.ui_select

        local extra = require("mini.extra").pickers
        local pick = m.builtin
        local map = vim.keymap.set

        -- Files
        map("n", "<leader>ff", pick.files, { desc = "[F]ind [F]iles" })
        map("n", "<leader>fb", pick.buffers, { desc = "[F]ind [B]uffers" })
        map("n", "<leader>fl", pick.grep_live, { desc = "[F]ind [L]ive grep" })
        map("n", "<leader>fh", pick.help, { desc = "[F]ind [H]elp tags" })

        -- LSP
        map("n", "<leader>fs", function()
          extra.lsp({ scope = "document_symbol" })
        end, { desc = "[F]ind [S]ymbols" })
        map("n", "<leader>fw", function()
          extra.lsp({ scope = "workspace_symbol" })
        end, { desc = "[F]ind [W]orkspace symbols" })
        map("n", "<leader>fr", function()
          extra.lsp({ scope = "references" })
        end, { desc = "[F]ind [R]eferences" })

        -- Diagnostics
        map("n", "<leader>fd", function()
          extra.diagnostic({ scope = "current" })
        end, { desc = "[F]ind Document [d]iagnostics" })
        map("n", "<leader>fD", function()
          extra.diagnostic({ scope = "all" })
        end, { desc = "[F]ind Workspace [D]iagnostics" })

        -- Quickfix / keymaps
        map("n", "<leader>fq", function()
          extra.list({ list_type = "quickfix" })
        end, { desc = "[F]ind [Q]uickfix" })
        map("n", "<leader>fk", function()
          extra.keymaps()
        end, { desc = "[F]ind [K]eymaps" })

        -- Git
        map("n", "<leader>fgf", function()
          extra.git_files()
        end, { desc = "[F]ind [G]it files" })
        map("n", "<leader>fgc", function()
          extra.git_commits()
        end, { desc = "[F]ind [G]it [C]ommits" })
        map("n", "<leader>fgb", function()
          extra.git_branches()
        end, { desc = "[F]ind [G]it [B]ranches" })

        -- Notifications
        map("n", "<leader>fn", function()
          local history = require("mini.notify").get_all()
          local items = vim.tbl_map(function(n)
            return string.format("[%s] %s %s", n.level, os.date("%H:%M:%S", n.ts_add), n.msg)
          end, history)
          m.start({
            source = {
              items = items,
              name = "Notifications",
              choose = function() end,
            },
          })
        end, { desc = "[F]ind past [N]otifications" })
      end,

      -- sa/sd/sr to add, delete, replace surrounding characters
      ["mini.surround"] = function(m)
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
  end,
}
