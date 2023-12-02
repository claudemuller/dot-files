-----------------------------------------------------------------------
-- [[ nvim-lsp config ]]
-----------------------------------------------------------------------

-- LSP Config & Plugins
-- See `:help ?.txt`
return {
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
		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end
		local on_attach = function(bufnr)
			-- NOTE: Remember that lua is a real programming language, and as such it is possible
			-- to define small helper and utility functions so you don't have to repeat yourself
			-- many times.
			--
			-- In this case, we create a function that lets us more easily define mappings specific
			-- for LSP related items. It sets the mode, buffer and description for us each time.
			local nmapl = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				nmap(keys, func, desc)
			end

			nmapl("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmapl("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

			nmapl("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmapl("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			nmapl("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmapl("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmapl("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			nmapl("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

			-- See `:help K` for why this keymap
			nmapl("K", vim.lsp.buf.hover, "Hover Documentation")
			nmapl("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

			-- Lesser used LSP functionality
			nmapl("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmapl("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmapl("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmapl("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		local servers = {
			clangd = {},
			gopls = {},
			golangci_lint_ls = {},
			pyright = {},
			rust_analyzer = {},
			tsserver = {},
			html = {},
			asm_lsp = {},
			bashls = {},
			cssls = {},
			cucumber_language_server = {},
			dockerls = {},
			docker_compose_language_service = {},
			jsonls = {},
			marksman = {},
			intelephense = {},
			ruby_ls = {},
			sqlls = {},
			taplo = {},
			lemminx = {},
			yamlls = {},
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							telemetry = false,
							globals = { "vim" },
						},
					},
				},
			}
			-- "autotools-language-server" = {},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local format_sync_grp = vim.api.nvim_create_augroup("AutoFormatting", {})

		-- Setup mason so it can manage external tooling
		require("mason").setup()

		local mason_lspconfig = require("mason-lspconfig")

		-- Ensure the servers above are installed
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
				})
			end,
		})
	end,
}
