return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = { "fang2hou/blink-copilot" },
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
      default = { "lsp", "copilot", "path", "buffer", "lazydev" },
      per_filetype = {
        gitcommit = { "path", "buffer" },
        markdown = { "path", "buffer" },
      },
      providers = {
        lsp = {
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
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
          fallbacks = { "lsp" },
        },
      },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
