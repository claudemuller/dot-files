-----------------------------------------------------------------------
-- [[ Trouble config ]]
-----------------------------------------------------------------------

local gh = require("functions").gh

vim.pack.add({ gh("folke/trouble.nvim") })

vim.api.nvim_create_user_command("Trouble", function(opts)
	-- open trouble with optional args
	require("trouble").open(opts.args)
end, { nargs = "?" })

require("trouble").setup({
	focus = true,
	position = "right",
	height = 15,
	width = 50,
	-- icons = true,
	mode = "lsp_references", -- default
	fold_open = "",
	fold_closed = "",
	auto_open = false,
	auto_close = true,
	use_diagnostic_signs = true,
})

local trouble = require("trouble")

-- Preview floating diagnostics (like preview_float)
vim.api.nvim_create_user_command("TroublePreview", function()
	trouble.open("diagnostics")
	-- floating preview
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.3)
	local height = math.floor(vim.o.lines * 0.3)
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = 2,
		col = 2,
		style = "minimal",
		border = "rounded",
	}
	vim.api.nvim_open_win(buf, true, opts)
end, {})

-- LSP definitions/references in split (like lsp_split)
vim.api.nvim_create_user_command("TroubleLspSplit", function()
	trouble.open("lsp_references")
	vim.cmd("wincmd L") -- move Trouble to right split
end, {})

-- Diagnostics in split (like diagnostics_split)
vim.api.nvim_create_user_command("TroubleDiagnosticsSplit", function()
	trouble.open("diagnostics")
	vim.cmd("wincmd L") -- move Trouble to right split
end, {})

-- Quickfix list
vim.api.nvim_create_user_command("TroubleQfList", function()
	trouble.open("quickfix")
end, {})

-- Symbols (workspace or buffer symbols)
vim.api.nvim_create_user_command("TroubleSymbols", function()
	trouble.open("symbols")
end, {})

--4️⃣ Keymap
vim.keymap.set("n", "<leader>td", ":TroubleDiagnosticsSplit<CR>", { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>tD", ":TroublePreview<CR>", { desc = "Toggle buffer diagnostics" })
vim.keymap.set("n", "<leader>ts", ":TroubleSymbols<CR>", { desc = "Toggle symbols" })
vim.keymap.set("n", "<leader>tl", ":TroubleLspSplit<CR>", { desc = "Toggle LSP definitions/references" })
vim.keymap.set("n", "<leader>tQ", ":TroubleQfList<CR>", { desc = "Toggle quickfix list" })
