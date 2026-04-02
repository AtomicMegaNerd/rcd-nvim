return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      filetypes = {
        markdown = false,
        gitcommit = false,
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
  end,
}
