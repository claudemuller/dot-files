-----------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------

local gh = require("functions").gh

--
vim.pack.add({ gh("neovim/nvim-lspconfig") })

-- Mason
vim.pack.add({
	gh("mason-org/mason-lspconfig.nvim"),
	gh("mason-org/mason.nvim"),
})

-- Multi select
vim.pack.add({
	{
		src = gh("mg979/vim-visual-multi"),
		version = "master",
	},
})

-- Noir theme
vim.pack.add({ gh("dzfrias/noir.nvim") })
vim.cmd("colorscheme noir")

-- Detect tabstop and shiftwidth automatically
vim.pack.add({ gh("tpope/vim-sleuth") })

-- Auto insert matching pairs
vim.pack.add({ gh("windwp/nvim-autopairs") })

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		require("nvim-autopairs").setup()
	end,
})

-- Auto-completion
vim.pack.add({
	gh("rafamadriz/friendly-snippets"),
	{
		src = gh("saghen/blink.cmp"),
		version = "v1.8.0",
	},
})

-- require("blink-cmp").setup({
-- 	keymap = { present = "default" },
-- 	signature = { enabled = true },
-- })

require("plugins.oil")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.trouble")
require("plugins.snacks")
require("plugins.whichkey")
require("plugins.conform")
require("plugins.gitsigns")
require("plugins.mini")
