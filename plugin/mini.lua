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
    m.setup({
      cursor = {
        timing = m.gen_timing.linear({ duration = 120, unit = "total" }),
      },
      scroll = {
        timing = function(_, n)
          return math.min(20 / n, 4)
        end,
      },
      resize = {
        timing = m.gen_timing.linear({ duration = 20, unit = "total" }),
      },
      open = {
        timing = m.gen_timing.linear({ duration = 20, unit = "total" }),
      },
      close = {
        timing = m.gen_timing.linear({ duration = 20, unit = "total" }),
      },
    })
  end,

  -- navigate jumps with [ and ] (buffers, diagnostics, hunks, etc.)
  ["mini.bracketed"] = function(m)
    m.setup()
  end,

  -- keymap hints popup (which-key alternative)
  ["mini.clue"] = function(m)
    m.setup({
      triggers = {
        { mode = { "n", "x" }, keys = "<Leader>" },
        { mode = { "n", "x" }, keys = "g" },
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },
        { mode = { "n", "x" }, keys = "z" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "t" },
      },
      clues = {
        m.gen_clues.g(),
        m.gen_clues.marks(),
        m.gen_clues.registers(),
        m.gen_clues.square_brackets(),
        m.gen_clues.windows(),
        m.gen_clues.z(),
        -- Leader group descriptions
        { mode = "n", keys = "<Leader>c", desc = "Code actions" },
        { mode = "n", keys = "<Leader>ct", desc = "Code toggles" },
        { mode = "n", keys = "<Leader>f", desc = "Fzf picker" },
        { mode = "n", keys = "<Leader>fg", desc = "Fzf git picker" },
        { mode = "n", keys = "<Leader>k", desc = "Health checks" },
        { mode = "n", keys = "<Leader>p", desc = "Package manager" },
        { mode = "n", keys = "<Leader>g", desc = "Neogit" },
        { mode = "n", keys = "<Leader>v", desc = "Coverage" },
      },
      window = {
        config = { width = "auto" },
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

  -- auto-completion engine
  ["mini.completion"] = function(m)
    m.setup({
      lsp_completion = {
        snippet_insert = nil,
      },
      fallback_action = "<C-x><C-f>",
    })

    -- fuzzy matching with stable ordering
    vim.opt.completeopt:append({ "fuzzy", "nosort" })

    -- tab/s-tab to navigate popup
    local imap_expr = function(lhs, rhs)
      vim.keymap.set("i", lhs, rhs, { expr = true })
    end
    imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
    imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

    -- CR accepts selected item, otherwise passthrough
    _G.cr_action = function()
      if vim.fn.complete_info()["selected"] ~= -1 then
        return "\25"
      end
      return "\r"
    end
    vim.keymap.set("i", "<CR>", "v:lua.cr_action()", { expr = true })

    -- advertise mini.completion capabilities to LSP servers (e.g. auto-import)
    vim.lsp.config("*", { capabilities = m.get_lsp_capabilities() })
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

  -- fancy notifier
  ["mini.notify"] = function(m)
    m.setup()
  end,

  -- extra operators: gs (sort), gm (duplicate), gx (exchange)
  ["mini.operators"] = function(m)
    m.setup()
  end,

  ["mini.splitjoin"] = function(m)
    m.setup()
  end,

  -- nvim start screen
  ["mini.starter"] = function(m)
    local banner = table.concat({
      "    ___   __                  _      __  ___                 _   __              __",
      "   /   | / /_____  ____ ___  (_)____/  |/  /__  ____ _____ _/ | / /__  _________/ /",
      "  / /| |/ __/ __ \\/ __ `__ \\/ / ___/ /|_/ / _ \\/ __ `/ __ `/  |/ / _ \\/ ___/ __  /",
      " / ___ / /_/ /_/ / / / / / / / /__/ /  / /  __/ /_/ / /_/ / /|  /  __/ /  / /_/ /",
      "/_/  |_\\__/\\____/_/ /_/ /_/_/\\___/_/  /_/\\___/\\__, /\\__,_/_/ |_/\\___/_/   \\__,_/",
      "                                             /____/",
    }, "\n")

    m.setup({
      evaluate_single = true,
      header = banner,
      items = {
        m.sections.recent_files(7, true),
        {
          {
            name = "Find files",
            action = "lua require('fzf-lua').files()",
            section = "Picker",
          },
          {
            name = "Live grep",
            action = "lua require('fzf-lua').live_grep()",
            section = "Picker",
          },
          {
            name = "Buffers",
            action = "lua require('fzf-lua').buffers()",
            section = "Picker",
          },
          {
            name = "Git files",
            action = "lua require('fzf-lua').git_files()",
            section = "Picker",
          },
        },
        m.sections.builtin_actions(),
      },
      content_hooks = {
        m.gen_hook.adding_bullet("  "),
        m.gen_hook.indexing("all", { "Builtin actions" }),
        m.gen_hook.aligning("center", "center"),
      },
      footer = function()
        local v = vim.version()
        return "Neovim v" .. v.major .. "." .. v.minor .. "." .. v.patch
      end,
    })
  end,

  -- minimal status line
  ["mini.statusline"] = function(m)
    m.setup()
  end,

  -- sa/sd/sr to add, delete, replace surrounding characters
  ["mini.surround"] = function(m)
    m.setup()
  end,

  ["mini.trailspace"] = function(m)
    m.setup()
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        if vim.bo.filetype == "markdown" then
          m.trim()
        end
      end,
    })
  end,
}

-- Iterate over each mini plugin and run setup() on it
for plugin_str, plugin_fn in pairs(mini_plugins) do
  local plugin = require(plugin_str)
  plugin_fn(plugin)
end
