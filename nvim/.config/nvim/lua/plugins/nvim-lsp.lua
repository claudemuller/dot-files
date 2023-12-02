local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local format_sync_grp = vim.api.nvim_create_augroup("AutoFormatting", {})


return { -- LSP Config & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Useful status updates for LSP
		"j-hui/fidget.nvim",

		-- Additional lua configuration
		"folke/neodev.nvim",
	},
	init = function()
		require("mason").setup({
			ensure_installed = {
				"clangd",
				"gopls",
				"golangci-lint-langserver",
				"pyright",
				"rust_analyzer",
				"tsserver",
				"lua_ls",
			},
		})

		local lspconfig = require("lspconfig")
		-- lspconfig.setup({
			-- ensure_installed = {
			-- 	"clangd",
			-- 	"gopls",
			-- 	"golangci_lint_ls",
			-- 	"pyright",
			-- 	"rust_analyzer",
			-- 	"tsserver",
			-- 	"lua_ls",
			-- },
		-- })

		lspconfig.lua_ls.setup({
			-- keys = {},
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					},
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace",
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		lspconfig.gopls.setup({})
		-- lspconfig.golanglint_ci.setup({})
		lspconfig.clangd.setup({})
		lspconfig.gopls.setup({})
		lspconfig.pyright.setup({})
		lspconfig.rust_analyzer.setup({})
		lspconfig.tsserver.setup({})
	end,
}

