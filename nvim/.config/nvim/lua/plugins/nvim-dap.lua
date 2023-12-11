-----------------------------------------------------------------------
-- [[ nvim-dap config ]]
-----------------------------------------------------------------------

-- Debugger
-- See `:help nvim-dap.txt`
return {
	"mfussenegger/nvim-dap",
	event = "BufReadPre",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		"leoluz/nvim-dap-go",
		"jbyuki/one-small-step-for-vimkind",
	},
	init = function()
		local on_attach = function(bufnr)
			vim.keymap.set("n", "<leader>Dr", function() require 'dap'.continue() end, { desc = "Debug run" })
			vim.keymap.set("n", "<F10>", function() require 'dap'.step_over() end, { desc = "Debug step over" })
			vim.keymap.set("n", "<F11>", function() require 'dap'.step_into() end, { desc = "Debug step into" })
			vim.keymap.set("n", "<F12>", function() require 'dap'.step_out() end, { desc = "Debug step out" })
			vim.keymap.set("n", "<leader>Dl", function() require("dap").run_last() end, { desc = "Debug run last" })
			vim.keymap.set("n", "<leader>Db", function() require("dap").toggle_breakpoint() end,
				{ desc = "Debug toggle breakpoint" })
		end
	end,
	config = function()

	end,
}
