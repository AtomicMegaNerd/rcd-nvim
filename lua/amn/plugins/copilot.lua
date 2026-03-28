return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
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
  },
  config = function(_, opts)
    require("copilot").setup(opts)
  end,
}
