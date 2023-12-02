-----------------------------------------------------------------------
-- [[ telescope-fzf-native.nvim config ]]
-----------------------------------------------------------------------

-- Fuzzy find in Telescope
-- See `:help telescope-fzf.txt`
return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		cond = vim.fn.executable("make") == 1,
	},
}

