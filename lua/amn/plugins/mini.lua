return {
  "nvim-mini/mini.nvim",
  version = "*",

  config = function()
    local utils = require("amn.utils")

    -- The plugin and their config functions live here...
    local mini_plugins = {
      ["mini.icons"] = function(m)
        m.setup()
      end,
      ["mini.surround"] = function(m)
        m.setup()
      end,
      ["mini.comment"] = function(m)
        m.setup()
      end,
      ["mini.statusline"] = function(m)
        m.setup()
      end,
      ["mini.diff"] = function(m)
        m.setup()
      end,
      ["mini.hipatterns"] = function(m)
        m.setup({
          highlighters = {
            hex_color = m.gen_highlighter.hex_color(),
          },
        })
      end,
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
      ["mini.ai"] = function(m)
        m.setup({
          custom_textobjects = {
            f = m.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
            c = m.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          },
        })
      end,
    }

    -- Iterate over each mini plugin and run setup() on it
    for plugin_str, plugin_fn in pairs(mini_plugins) do
      local plugin = utils.do_import(plugin_str)
      if not plugin then
        return
      end
      plugin_fn(plugin)
    end
  end,
}
