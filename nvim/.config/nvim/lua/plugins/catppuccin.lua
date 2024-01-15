-----------------------------------------------------------------------
-- [[ catppuccin config ]]
-----------------------------------------------------------------------

-- Set catppuccin theme
-- See `:help catppuccin.txt`
return {
	"catppuccin/nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("catppuccin").setup({
			custom_highlights = function(colors)
				return {
					-- Comment = { fg = colors.flamingo },
					-- TabLineSel = { bg = colors.pink },
					-- CmpBorder = { fg = colors.surface2 },
					-- Pmenu = { bg = colors.none },
					-- ["lsp."]
				}
			end,
		})

		vim.cmd([[colorscheme catppuccin]])
	end,
}

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function()
--     vim.cmd [[colorscheme tokyonight]]
--     require("tokyonight").setup({
--       style = "night",
--     })
--   end,
-- }
