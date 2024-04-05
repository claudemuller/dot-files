-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set('n', '<leader>L', ':Lazy<CR>', { desc = 'Open [L]azy' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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

-- Ctrl+Backspace to delete whole words in normal mode
-- vim.keymap.set('i', '<C-h>', '<Esc>dd', { noremap = true })
-- vim.keymap.set('i', '<C-H>', '<C-W>', { noremap = true })
-- vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = true })

-- File operations
vim.keymap.set('n', '<C-S-s>', '<cmd>:update<CR>', { noremap = true, desc = 'Save current buffer' })
local function save_all_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    -- Check if buffer is valid and is not a terminal buffer
    if vim.api.nvim_buf_is_valid(buf) and not vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd ':update'
      end)
    end
  end
end
-- check here - https://vi.stackexchange.com/questions/38848/how-can-i-map-ctrl-alt-letter-mappings-in-vim
vim.keymap.set('n', '<C-S-A-s>', save_all_buffers, { noremap = true, desc = 'Save all open buffers' })

-- Window management
-- vim.keymap.set("n", "<leader>w+", "<cmd>:vertical resize +10<cr>", { desc = "Increase pane split" })
-- vim.keymap.set("n", "<leader>w-", "<cmd>:vertical resize -10<cr>", { desc = "Decrease pane split" })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open diagnostics in floating' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics in quickfix' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open diagnostics in floating' })
-- vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics in quickfix' })

-- Git
-- vim.keymap.set('n', '<leader>Gg', ':Git commit and push<CR>', { desc = 'Move focus to the upper window' })
-- vim.keymap.set('n', '<leader>GP', ':Git push<CR>', { desc = 'Git push' })
-- vim.keymap.set('n', '<leader>Gp', ':Git pull<CR>', { desc = 'Git pull' })
-- vim.keymap.set('n', '<leader>Gc', ':Git commit<CR>', { desc = 'Git commit' })
-- vim.keymap.set('n', '<leader>Gl', ':Telescope git_commits<CR>', { desc = 'Git log' })
-- vim.keymap.set('n', '<leader>GS', ':Telescope git_status<CR>', { desc = 'Git status' })
-- vim.keymap.set('n', '<leader>Gt', ':Telescope git_stash<CR>', { desc = 'Git stash' })
