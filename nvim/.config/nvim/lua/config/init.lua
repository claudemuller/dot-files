-- Config -----------------------------------------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic settings
vim.opt.number = true         -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.scrolloff = 5         -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2        -- Tab width
vim.opt.shiftwidth = 2     -- Indent width
vim.opt.softtabstop = 2    -- Soft tab stop
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true  -- Case sensitive if uppercase in search
vim.opt.hlsearch = true   -- Highlight search results
vim.opt.incsearch = true  -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true                            -- Enable 24-bit colors
vim.opt.signcolumn = "yes"                              -- Always show sign column
vim.opt.colorcolumn = "100,120"                         -- Show column at 100 characters
vim.opt.showmatch = true                                -- Highlight matching brackets
vim.opt.matchtime = 2                                   -- How long to show matching bracket
vim.opt.cmdheight = 1                                   -- Command line height
vim.o.completeopt = "menu,menuone,popup,fuzzy,noselect" -- Completion options
vim.o.complete = "o"
vim.opt.showmode = false                                -- Don't show mode in command line
vim.opt.pumheight = 10                                  -- Popup menu height
vim.opt.pumblend = 10                                   -- Popup menu transparency
vim.opt.winblend = 0                                    -- Floating window transparency
vim.opt.conceallevel = 0                                -- Don't hide markup
vim.opt.concealcursor = ""                              -- Don't hide cursor line markup
vim.opt.synmaxcol = 300                                 -- Syntax highlighting limit
vim.o.winbar = "%F%="                                   -- Add the full path in the winbar

-- File handling
vim.opt.backup = false                            -- Don't create backup files
vim.opt.writebackup = false                       -- Don't create backup before writing
vim.opt.swapfile = false                          -- Don't create swap files
vim.opt.undofile = true                           -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300                          -- Faster completion
vim.opt.timeoutlen = 500                          -- Key timeout duration
vim.opt.ttimeoutlen = 0                           -- Key code timeout
vim.opt.autoread = true                           -- Auto reload files changed outside vim
vim.opt.autowrite = false                         -- Don't auto save

-- Behaviour settings
vim.opt.hidden = true                   -- Allow hidden buffers
vim.opt.errorbells = false              -- No error bells
vim.opt.backspace = "indent,eol,start"  -- Better backspace behavior
vim.opt.autochdir = false               -- Don't auto change directory
vim.opt.path:append("**")               -- include subdirectories in search
vim.opt.wildignore:append("**/node_modules/**,**/.git/**,**/target/**,**/dist/**")
vim.opt.mouse = "a"                     -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true               -- Allow buffer modifications
vim.opt.encoding = "UTF-8"              -- Set encoding

-- Cursor settings
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Folding settings
vim.opt.foldmethod = "expr"                     -- Use expression for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99                          -- Start with all folds open

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- UI
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono NF:h7.5:w0.01"
  vim.g.neovide_scale_factor = 1.0
end
