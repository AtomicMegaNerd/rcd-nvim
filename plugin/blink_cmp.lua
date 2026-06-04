local cmp = require("blink.cmp")
cmp.build():pwait()

cmp.setup({
  keymap = { preset = "enter" },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    list = { selection = { preselect = false, auto_insert = true } },
    menu = { draw = { columns = { { "label" }, { "kind_icon", "kind" }, { "source_name" } } } },
    ghost_text = { enabled = true },
  },

  sources = { default = { "lsp", "path", "buffer" } },

  signature = { enabled = true },
})
