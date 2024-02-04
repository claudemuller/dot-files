-----------------------------------------------------------------------
-- [[ Conform config ]]
-----------------------------------------------------------------------

-- Formatter managemint
-- See `:help confirm.txt`
return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			go = { "goimports", "gofumpt" },
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- Use a sub-list to run only the first available formatter
			javascript = { { "prettierd", "prettier" } },
		},
	},
}

