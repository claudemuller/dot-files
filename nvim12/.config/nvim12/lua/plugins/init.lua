-----------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------

local gh = require("functions").gh

-- nvim-lspconfig
vim.pack.add({ gh("neovim/nvim-lspconfig") })

-- mason
vim.pack.add({
	gh("mason-org/mason-lspconfig.nvim"),
	gh("mason-org/mason.nvim"),
})

-- multi select
vim.pack.add({ {
	src = gh("mg979/vim-visual-multi"),
	version = "master",
} })

-- themes ------------------------------------------------------------

-- vim.pack.add({ gh("folke/tokyonight.nvim") })
-- vim.cmd.colorscheme("tokyonight-night")

-- vim.pack.add({ gh("rebelot/kanagawa.nvim") })
-- vim.cmd.colorscheme("kanagawa-wave")

-- vim.pack.add({ gh("echasnovski/mini.nvim"), "http://github.com/claudemuller/retro-term.nvim") })
-- require("retro-term").setup({})

vim.pack.add({ gh("dzfrias/noir.nvim") })
vim.cmd("colorscheme noir")

-- vim.pack.add({ gh("y9san9/y9nika.nvim") })
-- vim.cmd.colorscheme("y9nika-monoaccent")

-- vim.pack.add({ gh("p00f/alabaster.nvim") })
--
-- vim.g.alabaster_dim_comments = 1
-- vim.g.alabaster_floatborder = 1
--
-- vim.cmd.colorscheme("alabaster")

-- debug keymappings
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.pack.add({ gh("folke/which-key.nvim") })
	end,
})

require("plugins.oil")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.trouble")
require("plugins.snacks")
require("plugins.whichkey")
require("plugins.conform")
