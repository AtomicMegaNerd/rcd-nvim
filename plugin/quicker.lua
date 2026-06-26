local quicker = require("quicker")
local map = vim.keymap.set

quicker.setup({
  keys = {
    {
      ">",
      function()
        quicker.expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        quicker.collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})

map("n", "<leader>xq", function()
  quicker.toggle()
end, { desc = "Toggle [Q]uickfix" })

map("n", "<leader>xl", function()
  quicker.toggle({ loclist = true })
end, { desc = "Toggle [L]oclist" })
