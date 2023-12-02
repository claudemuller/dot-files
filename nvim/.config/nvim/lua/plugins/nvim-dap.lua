return {
	enabled = false,
	"mfussenegger/nvim-dap",
	opt = true,
	event = "BufReadPre",
	module = { "dap" },
	wants = { "nvim-dap-virtual-text", "nvim-dap-ui" },
	requires = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		{ "leoluz/nvim-dap-go",                module = "dap-go" },
		{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
	},
	config = function()
		require("config.dap").setup()
	end,
}
