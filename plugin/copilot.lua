local copilot = require("copilot")
local suggestion = require("copilot.suggestion")
local blink = require("blink.cmp")

copilot.setup({
  panel = { enabled = false },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 75,
    trigger_on_accept = false,
    keymap = {
      accept_word = false,
      accept_line = false,
      toggle_auto_trigger = false,
    },
  },
})

local function notify(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = "Copilot", timeout = 1000 })
end

vim.keymap.set("i", "<M-Enter>", function()
  notify("Copilot Accepted")
  suggestion.accept()
end)

vim.keymap.set("i", "<M-Tab>", function()
  blink.hide()
  notify("Copilot Next Suggestion")
  suggestion.next()
end)

vim.keymap.set("i", "<M-S-Tab>", function()
  blink.hide()
  notify("Copilot Prev Suggestion")
  suggestion.prev()
end)

vim.keymap.set("i", "<M-Esc>", function()
  notify("Copilot Dismissed")
  suggestion.dismiss()
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
