-----------------------------------------------------------------------
-- [[ Conform config ]]
-----------------------------------------------------------------------

local gh = require("functions").gh

vim.pack.add({ gh("stevearc/conform.nvim") })

require("conform").setup({
	notify_on_error = true,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		cpp = { "clang-format" },
		go = { "gofmt", "goimports" },
		-- rust = { 'rustfmt', lsp_format = 'fallback' },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		yaml = { "yamlfmt" },
	},
	lang_to_formatters = {
		json = { "jq" },
	},
	formatters = {
		black = {
			prepend_args = { "-l", 120 },
		},
		prettier = {
			prepend_args = {
				"--print-width ",
				120,
				"--tab-width",
				4,
				"--arrow-parens",
				"avoid",
			},
		},
	},
})
