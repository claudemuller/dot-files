-----------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------

-- nvim-lspconfig
vim.pack.add({ "http://github.com/neovim/nvim-lspconfig" })

-- mason
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim", "https://github.com/mason-org/mason.nvim" })

-- neo-tree
-- vim.pack.add({
-- 	"http://github.com/nvim-lua/plenary.nvim",
-- 	"http://github.com/nvim-tree/nvim-web-devicons",
-- 	"http://github.com/MunifTanjim/nui.nvim",
-- 	--"http://github.com/3rd/image.nvim",
-- 	{ src = "http://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
-- })
-- require("neo-tree").setup({
-- 	vim.keymap.set("n", "<leader>fn", ":Neotree toggle<CR>", { desc = "Toggle neotree" } )
--     -- { '<leader>fts', ':Neotree document_symbols<CR>', desc = 'Toggel symbol view' },
-- })

require("plugins.telescope")

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

-- themes ------------------------------------------------------------

-- vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })
-- vim.cmd.colorscheme("tokyonight-night")

-- vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })
-- vim.cmd.colorscheme("kanagawa-wave")

-- vim.pack.add({ "https://github.com/echasnovski/mini.nvim", "http://github.com/claudemuller/retro-term.nvim" })
-- require("retro-term").setup({})

vim.pack.add({ "https://github.com/dzfrias/noir.nvim" })
vim.cmd("colorscheme noir")

-- vim.pack.add({ "https://github.com/y9san9/y9nika.nvim" })
-- vim.cmd.colorscheme("y9nika-monoaccent")

-- vim.pack.add({ "https://github.com/p00f/alabaster.nvim" })
--
-- vim.o.termguicolors = true
-- vim.g.alabaster_dim_comments = 1
-- vim.g.alabaster_floatborder = 1
--
-- vim.cmd.colorscheme("alabaster")
