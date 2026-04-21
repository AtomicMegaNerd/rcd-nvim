require("blink.cmp").setup({
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
    providers = {
      lsp = {
        -- This override is needed to add "!" as a trigger character for web filetypes, as it is
        -- commonly used in HTML and CSS for things like doctype declarations and important
        -- flags.
        override = {
          get_trigger_characters = function(self)
            local trigger_characters = self:get_trigger_characters()
            local web_filetypes = {
              "html",
              "css",
              "scss",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
            }
            if
              vim.tbl_contains(web_filetypes, vim.bo.filetype)
              and not vim.tbl_contains(trigger_characters, "!")
            then
              table.insert(trigger_characters, "!")
            end
            return trigger_characters
          end,
        },
      },
    },
  },
  signature = { enabled = true },
})
