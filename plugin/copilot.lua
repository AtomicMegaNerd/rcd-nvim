local copilot = require("copilot")
local suggest = require("copilot.suggestion")
local blink = require("blink.cmp")
local map = vim.keymap.set

copilot.setup({
  panel = { enabled = false },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 75,
    trigger_on_accept = true,
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

map("i", "<M-Enter>", function()
  notify("Copilot Accepted")
  suggest.accept()
end)

map("i", "<M-Tab>", function()
  blink.hide()
  notify("Copilot Next Suggestion")
  suggest.next()
end)

map("i", "<M-S-Tab>", function()
  blink.hide()
  notify("Copilot Prev Suggestion")
  suggest.prev()
end)

map("i", "<M-Esc>", function()
  notify("Copilot Dismissed")
  suggest.dismiss()
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
