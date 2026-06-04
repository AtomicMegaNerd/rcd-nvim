local cmp = require("blink.cmp")
cmp.build():pwait()

cmp.setup({
  appearance = {
    nerd_font_variant = "normal",
  },
  keymap = { preset = "enter" },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    menu = {
      draw = {
        columns = { { "label" }, { "kind_icon", "kind" }, { "source_name" } },
      },
    },
    trigger = {
      show_on_blocked_trigger_characters = { " ", "\n", "\t" },
    },
    ghost_text = { enabled = true },
  },
  sources = {
    default = { "lsp", "path", "buffer" },
  },
  signature = { enabled = true },
})
