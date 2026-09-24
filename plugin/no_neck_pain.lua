require("no-neck-pain").setup({
  width = 110, -- Need to account for signcolumn and numbercolumn
  minSideBufferWidth = 1,
  autocmds = {
    enableOnVimEnter = "safe",
  },
  mappings = {
    enabled = true,
  },
  integrations = {
    dashboard = {
      enabled = true,
      filetypes = { "ministarter" },
    },
  },
})
