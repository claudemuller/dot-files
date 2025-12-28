-----------------------------------------------------------------------
-- [[ Keymaps ]]
-----------------------------------------------------------------------

local fn = require("functions")

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

-- remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- file operations
vim.keymap.set("n", "<C-S-s>", "<cmd>:w<CR>", { noremap = true, desc = "Save current buffer" })
-- check here - https://vi.stackexchange.com/questions/38848/how-can-i-map-ctrl-alt-letter-mappings-in-vim
vim.keymap.set("n", "<C-S-A-s>", fn.save_all_buffers, { noremap = true, desc = "Save all open buffers" })

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- redo
vim.keymap.set("n", "<S-u>", ":redo<CR>", { silent = true })

-- center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- move code
vim.keymap.set("n", "<C-S-j>", ":m +1<cr>", { desc = "Move line down" })
vim.keymap.set("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("n", "<C-S-k>", ":m -2<cr>", { desc = "Move line up" })
vim.keymap.set("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move selected lines up" })

-- keybinds to make split navigation easier
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- easier pane resizing
vim.keymap.set("n", "<C-W><C-l>", "<cmd>:vertical resize +10<cr>", { desc = "Increase pane split" })
vim.keymap.set("n", "<C-W><C-h>", "<cmd>:vertical resize -10<cr>", { desc = "Decrease pane split" })

-- diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic message" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic errors" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Show diagnostic quickfix list" })
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostics in floating" })

-- toggle quickfix
vim.keymap.set("n", "<leader>qf", function() end, { desc = "Toggle quickfix window" })

-- copy full file path to clipboard
vim.keymap.set("n", "<leader>fc", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("Copied path: " .. path)
end, { desc = "Copy full file path to clipboard" })
