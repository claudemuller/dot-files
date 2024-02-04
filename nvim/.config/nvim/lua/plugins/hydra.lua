-----------------------------------------------------------------------
-- [[ Hydra config ]]
-----------------------------------------------------------------------

-- Hydra
-- See `:help hydra.txt`
return {
	"anuvyklack/hydra.nvim",
	dependencies = { "anuvyklack/keymap-layer.nvim" },
	-- opts = {},
	-- config = function()
	-- 	require("config.hydra")
	-- end
	keys = {
		{ "<leader>db", function() require('hydra').spawn("dap-hydra") end, desc = "Debug" },
		{ "<leader>r", function() require('hydra').spawn("run-hydra") end, desc = "Run" },
	},
}

