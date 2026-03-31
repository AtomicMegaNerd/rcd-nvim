-- Text yank
----------------------------------------------------------------
-- Automatically highlight text when we yank it
local yank_grp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  group = yank_grp,
  pattern = "*",
})

-- Options for specific file types
----------------------------------------------------------------
local fto_grp = vim.api.nvim_create_augroup("FileTypeOptions", { clear = true })

-- Set tabstop and shiftwidth to 2 for these file types
vim.api.nvim_create_autocmd("FileType", {
  command = "set tabstop=2 shiftwidth=2",
  group = fto_grp,
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

-- Do not convert tabs to spaces in these file types
vim.api.nvim_create_autocmd("FileType", {
  command = "set noexpandtab",
  group = fto_grp,
  pattern = { "bash", "sh", "go" },
})

-- The black Python formatter uses 88 characters as the line length
vim.api.nvim_create_autocmd("FileType", {
  command = "set colorcolumn=88",
  group = fto_grp,
  pattern = { "python" },
})

vim.api.nvim_create_autocmd("FileType", {
  command = "set colorcolumn=100",
  group = fto_grp,
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

-- Enable soft wrapping and line breaking in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = fto_grp,
  callback = function()
    vim.opt_local.wrap = true -- Enable soft wrapping
    vim.opt_local.linebreak = true -- Break lines at word boundaries
  end,
})

-- Treat these files as shell scripts
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  command = "setf sh",
  group = fto_grp,
  pattern = { "env.list", ".envrc", "*.env" },
})

-- Disable spelling for these file types
vim.api.nvim_create_autocmd("FileType", {
  command = "set nospell",
  group = fto_grp,
  pattern = { "yaml", "json", "toml", "xml" },
})

vim.api.nvim_create_augroup("Linting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "Linting",
  callback = function()
    local lint = require("lint")
    lint.try_lint()
  end,
})

-- LSP progress → Ghostty OSC 9;4 progress bar (Neovim 0.12+)
-- Bridges LspProgress events to nvim_echo progress messages, which cause
-- the TUI to emit OSC 9;4 sequences that Ghostty renders as a native progress bar.
----------------------------------------------------------------
local lsp_progress_grp = vim.api.nvim_create_augroup("LspProgressBar", { clear = true })
vim.api.nvim_create_autocmd("LspProgress", {
  group = lsp_progress_grp,
  callback = function(ev)
    local params = ev.data.params
    local value = params.value
    if type(value) ~= "table" then
      return
    end

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local client_name = client and client.name or "LSP"
    local id = client_name .. "." .. tostring(params.token)

    local is_done = value.kind == "end"
    vim.api.nvim_echo({}, false, {
      id = id,
      kind = "progress",
      title = value.title or client_name,
      source = client_name,
      percent = value.percentage,
      status = is_done and "success" or "running",
    })

    if is_done then
      vim.defer_fn(function()
        vim.cmd("echon ''")
      end, 0)
    end
  end,
})
