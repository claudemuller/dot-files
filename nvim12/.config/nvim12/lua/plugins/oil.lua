-- oil
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require('oil').setup({
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	view_options = {
		show_hidden = true,
	},
	float = {
		padding = 2,
		max_width = 0.75,
		max_height = 0.75,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
	},
	keymaps = {
		["<ESC>"] = { "actions.close", mode = "n" },
		["<C-v>"] = { "actions.select", opts = { vertical = true } },
		["<C-h>"] = { "actions.select", opts = { horizontal = true } },
	},
})
vim.keymap.set('n', '-', ':Oil --float<CR>', { silent = true })

