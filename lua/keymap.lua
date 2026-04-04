--     ___   __                  _      __  ___                 _   __              __
--    /   | / /_____  ____ ___  (_)____/  |/  /__  ____ _____ _/ | / /__  _________/ /
--   / /| |/ __/ __ \/ __ `__ \/ / ___/ /|_/ / _ \/ __ `/ __ `/  |/ / _ \/ ___/ __  /
--  / ___ / /_/ /_/ / / / / / / / /__/ /  / /  __/ /_/ / /_/ / /|  /  __/ /  / /_/ /
-- /_/  |_\__/\____/_/ /_/ /_/_/\___/_/  /_/\___/\__, /\__,_/_/ |_/\___/_/   \__,_/
--                                              /____/
--
-- Custom Neovim keybindings

-- Arrow keys
----------------------------------------------------------------
-- Disable arrow keys for editing
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")

-- Remap ; to : for normal mode
vim.keymap.set("n", ";", ":")

-- Left and right can switch buffers
vim.keymap.set("n", "<left>", "<cmd>bp<cr>")
vim.keymap.set("n", "<right>", "<cmd>bn<cr>")

-- Delete without overwriting the clipboard
vim.keymap.set("n", "x", '"_x')

-- Diagnostics
vim.keymap.set("n", "td", vim.diagnostic.open_float, { desc = "[T]oggle [D]iagnostic" })

-- Vim Pack
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Vim [P]ack [U]pdate" })

-- Health Checks
vim.keymap.set(
  "n",
  "<leader>kl",
  "<cmd>:checkhealth vim.lsp<cr>",
  { desc = "Chec[K] Health [L]sp" }
)
vim.keymap.set(
  "n",
  "<leader>kp",
  "<cmd>:checkhealth vim.pack<cr>",
  { desc = "Chec[K] Health [P]ack" }
)
vim.keymap.set(
  "n",
  "<leader>kt",
  "<cmd>:checkhealth nvim-treesitter<cr>",
  { desc = "Chec[K] Health [T]ree-sitter" }
)
