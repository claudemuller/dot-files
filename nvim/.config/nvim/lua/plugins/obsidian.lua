return {
	"epwalsh/obsidian.nvim",
	version = "*",  -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		-- "BufReadPre" .. vim.fn.expand "~" .. "repos/notes/**.md",
		"BufNewFile /home/lukefilewalker/repos/notes/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian"},
		{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes"},
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/repos/notes",
			},
			-- {
			-- 	name = "work",
			-- 	path = "~/vaults/work",
			-- },
		},
	},
}
