-----------------------------------------------------------------------
-- [[ telescope-fzf-native config ]]
-----------------------------------------------------------------------

-- Fuzzy find in Telescope
-- See `:help telescope-fzf.txt`
return {
	"nvim-telescope/telescope-fzf-native.nvim",
	build = "make",
	cond = vim.fn.executable("make") == 1,
}
