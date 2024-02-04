-----------------------------------------------------------------------
-- [[ Plugins w/ Defaults ]]
-----------------------------------------------------------------------

return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = true, -- runs require("Comment").setup()
	},
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
		},
	},
	"tpope/vim-sleuth",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter" },
	},
	"MunifTanjim/nui.nvim",
}
