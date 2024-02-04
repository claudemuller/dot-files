-----------------------------------------------------------------------
-- [[ Go config ]]
-----------------------------------------------------------------------

-- Go stuff
-- See `:help ??`
return {
	'ray-x/go.nvim',
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	init = function()
		require("go").setup()
		require("go.format").goimport() -- goimport + gofmt
	end,
	event = { "CmdlineEnter" },
	ft = {
		"go",
		"gomod",
	},
	setup = function()
		vim.cmd("GoInstallBinaries")
	end,
	build = ':lua require("go.install").update_all_sync()'
}

