-----------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------

-- nvim-lspconfig
vim.pack.add({ "http://github.com/neovim/nvim-lspconfig" })

-- mason
vim.pack.add({
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/mason-org/mason.nvim",
})

-- multi select
vim.pack.add({{
	src = "https://github.com/mg979/vim-visual-multi",
	version = "master",
}})

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

require("plugins.oil")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.trouble")
