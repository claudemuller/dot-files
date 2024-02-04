-----------------------------------------------------------------------
-- [[ Telescope config ]]
-----------------------------------------------------------------------

-- Fuzzy Finder (files, lsp, etc)
-- See `:help telescope.txt`
return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.4",
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = vim.fn.executable("make") == 1,
		},
	},
	opts = function()
		local actions = require("telescope.actions")

		return {
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			on_attach = function(buffer)
			end,
		}
	end,
	keys = {
		{ "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "Find recently opened files" },
		{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Find existing buffers" },
		{ "<leader>/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({winblend = 10, previewer = false}))<cr>", desc = "Fuzzily search in current buffer]" },

		{ "<leader>s", desc = "Search" },
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
		{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search current word" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search by grep" },
		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Search diagnostics" },
		{ "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Search registers" },
	},
	init = function()
		pcall(require("telescope").load_extension, "fzf")
	end,
}

