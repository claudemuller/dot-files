-- [[ [n]vim config ]]
-----------------------------------------------------------------------

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Link up system clipboard
vim.opt.clipboard = "unnamedplus"

-- Setup default tabstop and shiftwidth
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Log Level
vim.lsp.set_log_level("off")

-- Set line length indicators
vim.opt.colorcolumn = "100,120"
