-----------------------------------------------------------------------
-- [[ nvim-dap config ]]
-----------------------------------------------------------------------

-- Debugger
-- See `:help nvim-dap.txt`
return {
	enabled = false,
	"mfussenegger/nvim-dap",
	event = "BufReadPre",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		"leoluz/nvim-dap-go",
		"jbyuki/one-small-step-for-vimkind",
	},
	-- config = function()
	-- 	require("config.dap").setup()
	-- end,
	opts = {
		on_attach = function(buffer)
			vim.keymap.set("n", "<leader>dr", function() require 'dap'.continue() end, { desc = "[D]ebug [R]un" })
			vim.keymap.set("n", "<F10>", function() require 'dap'.step_over() end, { desc = "Debug [F10]Step Over" })
			vim.keymap.set("n", "<F11>", function() require 'dap'.step_into() end, { desc = "Debug [F11]Step Into" })
			vim.keymap.set("n", "<F12>", function() require 'dap'.step_out() end, { desc = "Debug [F12]Step Out" })
			vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "[D]ebug Run [L]ast" })
			-- nmap("<leader>db", function() require("dap").toggle_breakpoint() end, "[D]ebug Toggle [B]reakpoint")
		end,
	}
}
