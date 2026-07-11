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
vim.o.guicursor = "a:blinkon100-blinkoff100-blinkwait700"

-- Pretty windows
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
vim.o.pumheight = 10
vim.o.pummaxwidth = 100

-- Indentation
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.shiftwidth = 4 -- Number of spaces to (auto)indent

-- Show helpful text indicators
vim.o.list = true

-- Status line always visible and global
vim.o.laststatus = 3

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Better completion experience
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"

-- Nerd font
vim.g.have_nerd_font = true

-- Do not show the mode because it is already in the status line
vim.o.showmode = false

-- Highlight the current line
vim.o.cursorline = true

-- Disable tabline
vim.o.showtabline = 0

-- Lose the ~ on empty lines
vim.opt.fillchars = { eob = " " }

-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Limit shada for startup
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

-- Disable swap files
vim.o.swapfile = false

-- Save undo history
vim.o.undofile = true

-- Disable provider health checks
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Enable experimental ui2
require("vim._core.ui2").enable({})
