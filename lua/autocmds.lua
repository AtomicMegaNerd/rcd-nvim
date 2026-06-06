local amn_grp = vim.api.nvim_create_augroup("AtomicMegaNerdGroup", { clear = true })

-- These languages are best using 2-spaces for indentation
local two_space = {
  "haskell",
  "lua",
  "terraform",
  "nix",
  "markdown",
  "yaml",
  "html",
  "xml",
  "css",
  "json",
  "scss",
  "toml",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}

-- These languages use tabs instead of spaces
local use_tabs = {
  "go",
  "make",
}

-- This autocmd controls indentation and tabs vs. spaces for
-- all our file types
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = args.match
    -- Default to spaces
    vim.bo[args.buf].expandtab = true
    -- Set indendtation to 2 for languages in two_space table
    if vim.tbl_contains(two_space, ft) then
      vim.bo[args.buf].tabstop = 2
      vim.bo[args.buf].shiftwidth = 2
    end
    -- Use tabs for languages in the use_tabs table
    if vim.tbl_contains(use_tabs, ft) then
      vim.bo[args.buf].expandtab = false
    end
  end,
  group = amn_grp,
  pattern = { "*" },
})

-- For setting colorcolumn, Python is unique and has 88 cols standard, but we want to set
-- it back to 100 for all other file types
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    vim.opt_local.colorcolumn = args.match == "python" and "88" or "100"
  end,
  group = amn_grp,
  pattern = { "*" },
})

-- Treat these files as shell scripts
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  command = "setf sh",
  group = amn_grp,
  pattern = { "env.list", ".envrc", "*.env" },
})
