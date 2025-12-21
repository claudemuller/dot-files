-----------------------------------------------------------------------
-- [[ Keymaps ]]
-----------------------------------------------------------------------

local fn = require 'functions'

--vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
--vim.keymap.set("n", "gr", function()
--	local clients = vim.lsp.get_clients({ bufnr = 0 })
--	for _, client in ipairs(clients) do
--		if client.server_capabilities.referencesProvider then
--			vim.lsp.buf.references()
--			break -- Only use first capable client
--		end
--	end
--
--	-- vim.cmd("vertical copen")
--	vim.cmd("copen")
--	-- Focus on qf win
--	vim.cmd("wincmd j")
--	-- Move qf win to right of editor
--	-- vim.cmd("wincmd L")
--end, { desc = "LSP: Find References" })

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		local line = vim.api.nvim_win_get_cursor(0)[1] - 1
		local diags = vim.diagnostic.get(0, { lnum = line })
		if #diags > 0 then
			vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
		end
	end,
})

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Redo
vim.keymap.set('n', '<S-u>', ':redo<CR>', { silent = true })

-- Move code
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
