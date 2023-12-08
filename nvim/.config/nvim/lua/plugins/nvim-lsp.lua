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
	servers = {
		-- Ensure mason installs the server
		rust_analyzer = {
			keys = {
				{ "K",          "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
				{ "<leader>cR", "<cmd>RustCodeAction<cr>",   desc = "Code Action (Rust)" },
				{ "<leader>dr", "<cmd>RustDebuggables<cr>",  desc = "Run Debuggables (Rust)" },
			},
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						runBuildScripts = true,
					},
					-- Add clippy lints for Rust.
					checkOnSave = {
						allFeatures = true,
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
				},
			},
		},
		taplo = {
			keys = {
				{
					"K",
					function()
						if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
							require("crates").show_popup()
						else
							vim.lsp.buf.hover()
						end
					end,
					desc = "Show Crate Documentation",
				},
			},
		},
	},
	setup = {
		rust_analyzer = function(_, opts)
			local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
			require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
			return true
		end,
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

			nmapl("<leader>rn", vim.lsp.buf.rename, "Rename")
			nmapl("<leader>ca", vim.lsp.buf.code_action, "Code action")

			nmapl("gd", vim.lsp.buf.definition, "Goto definition")
			nmapl("gr", require("telescope.builtin").lsp_references, "Goto references")
			nmapl("gI", vim.lsp.buf.implementation, "Goto implementation")
			nmapl("<leader>D", vim.lsp.buf.type_definition, "Type definition")
			nmapl("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
			nmapl("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")

			-- See `:help K` for why this keymap
			nmapl("K", vim.lsp.buf.hover, "Hover documentation")
			nmapl("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

			-- Lesser used LSP functionality
			nmapl("gD", vim.lsp.buf.declaration, "Goto declaration")
			nmapl("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace add folder")
			nmapl("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace remove folder")
			nmapl("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "Workspace list folders")

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		local servers = {
			clangd = {},
			-- codelldb = {},
			gopls = {},
			golangci_lint_ls = {},
			pyright = {},
			rust_analyzer = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					runBuildScripts = true,
				},
				-- Add clippy lints for Rust.
				checkOnSave = {
					allFeatures = true,
					command = "clippy",
					extraArgs = { "--no-deps" },
				},
				procMacro = {
					enable = true,
					ignored = {
						["async-trait"] = { "async_trait" },
						["napi-derive"] = { "napi" },
						["async-recursion"] = { "async_recursion" },
					},
				},
			},
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
