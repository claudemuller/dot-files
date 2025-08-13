-----------------------------------------------------------------------
-- [[ [n]vim config ]]
-----------------------------------------------------------------------

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Line numbers
vim.opt.number = true
-- Relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Setup default tabstop and shiftwidth
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Set highlight on search
vim.o.hlsearch = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 0

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Add the full path in the winbar
vim.o.winbar = '%F%='

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- vim.cmd [[highlight Visual guifg=Black guibg=White ctermfg=Black ctermbg=White]]

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Set line length indicators
vim.opt.colorcolumn = '100,120'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Set backspace to "normal" behaviour
-- vim.opt.backspace = 'indent,eol,start'

-- Obsidian checkbox rendering thing
vim.opt_local.conceallevel = 1

-- Enable loading of local configs
vim.opt.exrc = true
vim.opt.secure = true

-- Show folds in column
vim.opt.foldcolumn = '1'

-- Log Level
-- vim.lsp.set_log_level 'off'
