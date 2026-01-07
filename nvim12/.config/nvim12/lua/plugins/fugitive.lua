-----------------------------------------------------------------------
-- [[ Fugitie config ]]
-----------------------------------------------------------------------

local gh = require("functions").gh

vim.pack.add({
	gh("tpope/vim-rhubarb"),
	gh("tpope/vim-fugitive"),
})

-- Keymaps

--     { '<leader>gs', ':Git<cr>', desc = 'Status', mode = { 'n', 'v' } },
--     { '<leader>gc', ':Git commit<cr>', desc = 'Commit', mode = { 'n', 'v' } },
--     { '<leader>gp', ':Git pull<cr>', desc = 'Pull', mode = { 'n', 'v' } },
--     { '<leader>gP', ':Git push<cr>', desc = 'Push', mode = { 'n', 'v' } },
--     { '<leader>gll', ':Gllog<cr>', desc = 'Log', mode = { 'n', 'v' } },
--
--     { '<leader>gdh', ':Gdiff :0<cr>', desc = 'Hunk', mode = { 'n', 'v' } },
--     { '<leader>gdm', ':Gvdiffsplit master<cr>', desc = 'With master', mode = { 'n', 'v' } },
--
--     { '<leader>gC', ':Git mergetool<cr>', desc = 'Show merge conflicts', mode = { 'n', 'v' } },
--     { '<leader>gR', ':Gvdiffsplit!<cr>', desc = 'Resolve conflicts', mode = { 'n', 'v' } },
--     { '<localleader>gdT', ':diffget //3<cr>', desc = 'Accept theirs', mode = { 'n', 'v' } },
--     { '<localleader>gdM', ':diffget //2<cr>', desc = 'Accept mine', mode = { 'n', 'v' } },
--
--     { '<localleader>gBf', ':Git blame<cr>', desc = 'Git blame', mode = { 'n', 'v' } },
--   },
-- },
--
