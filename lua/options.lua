--     ___   __                  _      __  ___                 _   __              __
--    /   | / /_____  ____ ___  (_)____/  |/  /__  ____ _____ _/ | / /__  _________/ /
--   / /| |/ __/ __ \/ __ `__ \/ / ___/ /|_/ / _ \/ __ `/ __ `/  |/ / _ \/ ___/ __  /
--  / ___ / /_/ /_/ / / / / / / / /__/ /  / /  __/ /_/ / /_/ / /|  /  __/ /  / /_/ /
-- /_/  |_\__/\____/_/ /_/ /_/_/\___/_/  /_/\___/\__, /\__,_/_/ |_/\___/_/   \__,_/
--                                              /____/
--

-- Set highlight on search
vim.o.hlsearch = false

-- Leader
vim.g.mapleader = "\\"

-- Make line numbers default, then make them relative, also set column
vim.o.relativenumber = true
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "100"

-- Scroll offset means the cursor will be x lines away from the top/bottom of the screen after
-- scrolling
vim.o.scrolloff = 10

-- Disable mouse support
vim.o.mouse = ""

-- Blinking block cursor!
vim.o.guicursor = "a:blinkon100"

vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.shiftwidth = 4 -- Number of spaces to (auto)indent

-- Pretty windows
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
vim.o.pumheight = 3

-- Indentation
vim.o.breakindent = true

-- Status line always visible and global
vim.o.laststatus = 3

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Better completion experience
vim.o.completeopt = "menuone,noselect,noinsert"

-- Nerd font
vim.g.have_nerd_font = true

-- Do not show the mode because it is already in the status line
vim.o.showmode = false

-- Highlight the current line
vim.o.cursorline = true

-- Clipboard
vim.o.clipboard = "unnamed,unnamedplus"

-- Disable swap files
vim.o.swapfile = false

-- Disable provider health checks
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Update times and timeouts.
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10
