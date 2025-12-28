-----------------------------------------------------------------------
-- [[ [n]vim config ]]
-----------------------------------------------------------------------

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("syntax on")

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Line numbers
vim.o.number = true
-- Relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Setup default tabstop and shiftwidth
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.autocomplete = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,popup,fuzzy,noselect"
vim.o.complete = "o"

-- Set highlight on search
vim.o.hlsearch = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Add the full path in the winbar
vim.o.winbar = "%F%="

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.o.list = true
-- vim.o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- vim.cmd [[highlight Visual guifg=Black guibg=White ctermfg=Black ctermbg=White]]

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Set line length indicators
vim.o.colorcolumn = "100,120"

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

-- Set backspace to "normal" behaviour
-- vim.o.backspace = 'indent,eol,start'

-- Obsidian checkbox rendering thing
vim.opt_local.conceallevel = 1

-- Use ripgrep for grepping
vim.opt.grepprg = "rg --vimgrep --no-messages --smart-case"

vim.opt.statusline = "[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P"

-- Enable loading of local configs
vim.o.exrc = true
vim.o.secure = true

-- Show folds in column
vim.o.foldcolumn = "1"

-- Log Level
-- vim.lsp.set_log_level 'off'

-- disable mouse popup yet keep mouse enabled
vim.cmd([[
  aunmenu PopUp
  autocmd! nvim.popupmenu
]])
