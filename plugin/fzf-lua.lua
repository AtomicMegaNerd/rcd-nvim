local fzf = require("fzf-lua")

fzf.setup({
  -- Use mini.icons (already shimmed as nvim-web-devicons, but explicit is better)
  defaults = {
    icon_provider = "mini",
  },
  winopts = {
    backdrop = 100,
  },
})

local map = vim.keymap.set

-- Files
map("n", "<leader>ff", fzf.files, { desc = "[F]ind [F]iles" })
map("n", "<leader>fb", fzf.buffers, { desc = "[F]ind [B]uffers" })
map("n", "<leader>fl", fzf.live_grep, { desc = "[F]ind [L]ive grep" })
map("n", "<leader>fh", fzf.help_tags, { desc = "[F]ind [H]elp tags" })

-- LSP
map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "[F]ind [S]ymbols" })
map("n", "<leader>fw", fzf.lsp_workspace_symbols, { desc = "[F]ind [W]orkspace symbols" })

-- Diagnostics
map("n", "<leader>fd", fzf.diagnostics_document, { desc = "[F]ind Document [d]iagnostics" })
map("n", "<leader>fD", fzf.diagnostics_workspace, { desc = "[F]ind Workspace [D]iagnostics" })

-- Lists / other
map("n", "<leader>fq", fzf.quickfix, { desc = "[F]ind [Q]uickfix" })
map("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })

-- Todo comments
map("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "[F]ind [T]odos" })

-- Git
map("n", "<leader>fgf", fzf.git_files, { desc = "[F]ind [G]it [F]iles" })
map("n", "<leader>fgc", fzf.git_commits, { desc = "[F]ind [G]it [C]ommits" })
map("n", "<leader>fgb", fzf.git_branches, { desc = "[F]ind [G]it [B]ranches" })
