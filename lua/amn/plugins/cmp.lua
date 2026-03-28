return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    appearance = {
      nerd_font_variant = "normal",
    },
    keymap = { preset = "super-tab", ["<CR>"] = { "hide", "fallback" } },
    completion = {
      menu = {
        draw = {
          columns = { { "label" }, { "kind_icon", "kind" }, { "source_name" } },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "buffer", "lazydev" },
      per_filetype = {
        gitcommit = { "path", "buffer" },
        markdown = { "path", "buffer" },
      },
      providers = {
        lsp = {
          score_offset = 3,
          max_items = 3,
          -- This override is needed to add "!" as a trigger character for html
          override = {
            get_trigger_characters = function(self)
              local chars = self:get_trigger_characters()
              if vim.bo.filetype == "html" and not vim.tbl_contains(chars, "!") then
                table.insert(chars, "!")
              end
              return chars
            end,
          },
        },
        path = { max_items = 3 },
        buffer = { max_items = 3 },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
          max_items = 3,
          fallbacks = { "lsp" },
        },
      },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
