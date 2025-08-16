-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local fn = require 'functions'

vim.keymap.set('n', '<leader>L', ':Lazy<CR>', { desc = 'Show Lazy' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Redo
vim.keymap.set('n', '<S-u>', ':redo<CR>', { silent = true })

-- File operations
vim.keymap.set('n', '<C-S-s>', '<cmd>:w<CR>', { noremap = true, desc = 'Save current buffer' })
-- check here - https://vi.stackexchange.com/questions/38848/how-can-i-map-ctrl-alt-letter-mappings-in-vim
vim.keymap.set('n', '<C-S-A-s>', fn.save_all_buffers, { noremap = true, desc = 'Save all open buffers' })

-- Switch between .c and .h files
vim.keymap.set('n', '<C-7>', fn.switch_c_h, { noremap = true, desc = 'Switch between .c/.c++ and .h files' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-W><C-l>', '<cmd>:vertical resize +10<cr>', { desc = 'Increase pane split' })
vim.keymap.set('n', '<C-W><C-h>', '<cmd>:vertical resize -10<cr>', { desc = 'Decrease pane split' })
vim.keymap.set('n', 'Q', 'q', { desc = 'Record a macro' })
vim.keymap.set('n', 'q', ':q<cr>', { desc = 'Close current window' })
-- vim.keymap.set('n', 'qf', ':cclose<cr>', { desc = 'Close quickfix' })

vim.keymap.set('n', '<C-S-j>', ':m +1<cr>', { desc = 'Move line down' })
vim.keymap.set('v', '<C-S-j>', ":m '>+1<cr>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('n', '<C-S-k>', ':m -2<cr>', { desc = 'Move line up' })
vim.keymap.set('v', '<C-S-k>', ":m '<-2<cr>gv=gv", { desc = 'Move selected lines up' })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic errors' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Show diagnostic quickfix list' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Show diagnostics in floating' })

-- Naughty naughty
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Obsidian
vim.keymap.set('n', '<leader>Odn', fn.obsidian.create_new_day, { desc = 'New daily note' })
vim.keymap.set('n', '<leader>Odc', fn.obsidian.copy_this_day, { desc = 'Copy current note' })

-- Code Notes
-- vim.keymap.set('n', '<leader>Na', fn.code_notes.add_note, { desc = 'Add a new note at cursor' })
-- vim.api.nvim_set_keymap('n', '<leader>Nd', delete_note, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>Nt', fn.code_notes.toggel_notes, { desc = 'Toggle notes' })

-- Octo
vim.keymap.set('n', '<leader>go', ':Octo actions<cr>', { desc = 'Open Octo' })

-- Toggle colorizer
vim.keymap.set('n', '<leader>uC', ':ColorizerAttachToBuffer<cr>', { desc = 'Attach Colorizer to buffer' })

-- Copy full file path to clipboard
vim.keymap.set('n', '<leader>fc', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('Copied path: ' .. path)
end, { desc = 'Copy full file path to clipboard' })
