return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim"
	},
	opts = {
		adapters = {
			["neotest-go"] = {
				-- Here we can set options for neotest-go, e.g.
				-- args = { "-tags=integration" }
			},
			["neotest-rust"] = {},
		},
		status = { virtual_text = true },
		output = { open_on_run = true },
		quickfix = {
			open = function()
				if require("lazyvim.util").has("trouble.nvim") then
					require("trouble").open({ mode = "quickfix", focus = false })
				else
					vim.cmd("copen")
				end
			end,
		},
	}
}
