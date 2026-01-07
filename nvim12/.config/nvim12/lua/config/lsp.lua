-----------------------------------------------------------------------
-- LSP + Language servers
-----------------------------------------------------------------------

local fn = require("functions")

local lsps = {
	{ "bashls" },
	{ "ccls" },
	{ "docker_language_server" }, -- dockerls
	{
		"clangd",
		{
			-- capabilities = { signatureHelpProvider = false },
			cmd = {
				"clangd",
				"--background-index", -- Index all project files
				"--clang-tidy", -- Optional: enable clang-tidy
				"--completion-style=detailed", -- Better completions
				"--compile-commands-dir=build", -- Path to compile_commands.json
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_dir = function(bufnr)
				return vim.fs.root(bufnr, {
					"compile_commands.json",
					"compile_flags.txt",
					".git",
				})
			end,
		},
	},
	{ "cssls" },
	{ "eslint" },
	{ "gitlab_ci_ls" },
	{ "golangci_lint_ls" },
	{ "gopls" },
	{
		"intelephense",
		{
			root_dir = function(fname)
				return vim.loop.cwd()
			end,
		},
	},
	{ "java_language_server" },
	{ "jsonls" },
	{ "jsonnet_ls" },
	{
		"lua_ls",
		{
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
				workspace = {
					checkThirdParty = false,
					-- Tells lua_ls where to find all the Lua files that you have loaded
					-- for your neovim configuration.
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
					-- If lua_ls is really slow on your computer, you can try this instead:
					-- library = { vim.env.VIMRUNTIME },
				},
			},
		},
	},
	{
		"ltex",
		{
			settings = {
				filetypes = { "markdown", "text" },
				flags = { debounce_text_changes = 300 },
				language = "en-GB",
			},
		},
	},
	{ "marksman" },
	{ "ols" },
	{ "powershell_es" },
	{ "pyright" },
	{ "rust_analyzer" },
	{ "sqls" },
	{ "ts_ls" },
}

-- Mason

local mason_map = {
	ccls = "clangd",
	docker_language_server = "dockerls",
	java_language_server = "jdtls",
}

local servers_to_install = {}
for _, lsp in ipairs(lsps) do
	local name = mason_map[lsp[1]] or lsp[1]
	table.insert(servers_to_install, name)
end

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers_to_install,
})

-- Enable LSPs

for _, lsp in ipairs(lsps) do
	local name, config = lsp[1], lsp[2] or {}
	config = config or {}

	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
	max_width = 80,
	max_height = 20,
})
