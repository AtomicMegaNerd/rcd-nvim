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
----------------------------------------------------------------
vim.keymap.set("n", ";", ":")

-- Left and right can switch buffers
----------------------------------------------------------------
vim.keymap.set("n", "<left>", "<cmd>bp<cr>")
vim.keymap.set("n", "<right>", "<cmd>bn<cr>")

-- Undo/Redo re-mappings (always use the leader key)
----------------------------------------------------------------
vim.keymap.set("n", "u", "<nop>")
vim.keymap.set("n", "U", "<nop>")
vim.keymap.set("n", "<C-r>", "<nop>")
vim.keymap.set("n", "<leader>u", "u", { desc = "Undo" })
vim.keymap.set("n", "<leader>U", "U", { desc = "Undo Line" })
vim.keymap.set("n", "<leader>r", "<C-r>", { desc = "Redo" })

-- Delete without overwriting the clipboard
----------------------------------------------------------------
vim.keymap.set("n", "x", '"_x')

-- Diagnostics
----------------------------------------------------------------
vim.keymap.set("n", "td", vim.diagnostic.open_float, { desc = "[T]oggle [D]iagnostic" })

-- Vim Pack
----------------------------------------------------------------
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Vim [P]ack [U]pdate" })

-- Health Checks
----------------------------------------------------------------
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

-- Directory Management key mappings
----------------------------------------------------------------
vim.keymap.set(
  "n",
  "<leader>dc",
  "<cmd>:lcd %:p:h<cr>",
  { desc = "[D]irectory change to [C]urrent file directory" }
)
vim.keymap.set("n", "<leader>dr", function()
  local root = vim.fs.root(0, { ".git" })
  if root then
    vim.cmd.lcd(root)
  end
end, { desc = "[D]irectory change to [R]oot" })
vim.keymap.set("n", "<leader>dl", "<cmd>lcd -<cr>", { desc = "[D]irectory change to [L]ast" })

-- Disable creating and jumpint to marks
----------------------------------------------------------------
vim.keymap.set({ "n", "v" }, "m", "<Nop>")
vim.keymap.set({ "n", "v" }, "'", "<Nop>")
vim.keymap.set({ "n", "v" }, "`", "<Nop>")
