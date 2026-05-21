local amn_grp = vim.api.nvim_create_augroup("AtomicMegaNerdGroup", { clear = true })

-- Use tabs in these file types
vim.api.nvim_create_autocmd("FileType", {
  command = "setlocal noexpandtab",
  group = amn_grp,
  pattern = { "go", "make" },
})

-- Use 2-space indentation with spaces
vim.api.nvim_create_autocmd("FileType", {
  command = "setlocal tabstop=2 shiftwidth=2 expandtab",
  group = amn_grp,
  pattern = {
    "haskell",
    "lua",
    "terraform",
    "nix",
    "markdown",
    "yaml",
    "html",
    "css",
    "json",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})

-- Use spaces (default tabstop) in these file types
vim.api.nvim_create_autocmd("FileType", {
  command = "setlocal expandtab",
  group = amn_grp,
  pattern = {
    "python",
    "dockerfile",
    "toml",
    "xml",
    "bash",
    "sh",
    "shell",
  },
})

-- The black Python formatter uses 88 characters as the line length
vim.api.nvim_create_autocmd("FileType", {
  command = "setlocal colorcolumn=88",
  group = amn_grp,
  pattern = { "python" },
})

vim.api.nvim_create_autocmd("FileType", {
  command = "setlocal colorcolumn=100",
  group = amn_grp,
  pattern = {
    "markdown",
    "lua",
    "go",
    "dockerfile",
    "shell",
    "sh",
    "bash",
    "javascript",
    "typescript",
    "yaml",
    "json",
    "toml",
  },
})

-- Treat these files as shell scripts
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  command = "setf sh",
  group = amn_grp,
  pattern = { "env.list", ".envrc", "*.env" },
})

-- Disable spelling for these file types
vim.api.nvim_create_autocmd("FileType", {
  command = "setlocal nospell",
  group = amn_grp,
  pattern = { "yaml", "json", "toml", "xml" },
})
