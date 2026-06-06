local cmp = require("blink.cmp")
cmp.build():pwait()

cmp.setup({
  keymap = { preset = "enter" },

  completion = {
    list = { selection = { preselect = true, auto_insert = true } },
    menu = {
      draw = {
        columns = { { "label" }, { "kind_icon", "kind" }, { "source_name" } },
      },
    },
    ghost_text = { enabled = true },
  },

  sources = {
    default = { "lsp", "path", "buffer" },
    per_filetype = {
      markdown = { "lsp", "path" },
    },
  },

  signature = { enabled = true },
})
