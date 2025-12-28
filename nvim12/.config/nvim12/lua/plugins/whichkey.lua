-----------------------------------------------------------------------
-- [[ WhichKey config ]]
-----------------------------------------------------------------------

local gh = require("functions").gh

vim.pack.add({ gh("folke/which-key.nvim") })

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Enable WhichKey labels",
	callback = function()
		require("which-key").add({
			{ "<leader>d", group = "Diagnostics" },

			{ "<leader>c", group = "Code" },
			-- { '<leader>cg', group = 'Generate' },
			-- { '<leader>cr', group = 'Remove' },
			-- { '<leader>cr', group = 'Rename' },
			-- { '<leader>cf', group = 'Fill' },

			{ "<leader>l", group = "LSP" },
			{ "<leader>T", group = "Test" },
			{ "<leader>D", group = "Debug" },

			{ "<leader>s", group = "Search" },
			-- { '<leader>sf', group = 'Files' },
			-- { '<leader>ss', group = 'Symbols' },
			-- { '<leader>sg', group = 'Grep' },

			-- { '<leader>O', group = 'Obsidian' },
			-- { '<leader>Od', group = 'Daily' },

			{ "<leader>f", group = "File" },
			-- { '<leader>ft', group = 'Toggle' },

			-- { '<leader>h', group = 'Hints' },
			-- { '<leader>ht', group = 'Toggle' },

			{ "<leader>v", group = "Version Control (Git)" },
			{ "<leader>vh", group = "Hunk" },
			{ "<leader>vt", group = "Toggle" },
			{ "<leader>vd", group = "Diff" },
			{ "<leader>vl", group = "Log" },
			{ "<leader>vL", group = "Lazygit" },

			{ "<leader>u", group = "Toggle UI features" },

			{ "<leader>t", group = "Trouble" },

			-- { '<leader>n', group = 'Notifications' },

			{ "<leader>b", group = "Buffers" },
			{ "<leader>S", group = "Scratch buffer" },

			{ "<leader>q", group = "Toggle Quickfix window" },
		})
	end,
})
