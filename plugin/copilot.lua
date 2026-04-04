require("copilot").setup({
  filetypes = {
    markdown = false,
    gitcommit = false,
  },
  server_opts_overrides = {
    settings = {
      telemetry = {
        telemetryLevel = "none",
      },
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    keymap = {
      accept = "<C-y>",
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<Esc>",
    },
  },
  panel = { enabled = false },
})
