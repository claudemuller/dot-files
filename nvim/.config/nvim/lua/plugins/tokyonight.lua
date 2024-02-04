-----------------------------------------------------------------------
-- [[ Tokyonight ]]
-----------------------------------------------------------------------

-- Set tokyonight theme
-- See `:help tokyonight.nvim.txt`
return {
	"folke/tokyonight.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("tokyonight").setup({
			style = "night"
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
