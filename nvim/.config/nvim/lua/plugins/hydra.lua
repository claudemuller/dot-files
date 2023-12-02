-----------------------------------------------------------------------
-- [[ hydra config ]]
-----------------------------------------------------------------------

-- Hydra
-- See `:help hydra.txt`
return {
	enabled = false,
	"anuvyklack/hydra.nvim",
	requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
	opts = {},
	-- config = function()
	-- 	require("config.hydra")
	-- end
	-- HYdra
	--vim.keymap.set("n", "<leader>db", function() require('hydra').spawn("dap-hydra") end, { desc = "[D]e[bug]" })
	--vim.keymap.set("n", "<leader>r", function() require('hydra').spawn("run-hydra") end, { desc = "[R]un" })

}
