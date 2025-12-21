-- LSP

local lsps = {
	{ "clangd", {
		-- capabilities = { signatureHelpProvider = false },
		cmd = {
			'clangd',
			'--background-index', -- Index all project files
			'--clang-tidy', -- Optional: enable clang-tidy
			'--completion-style=detailed', -- Better completions
			'--compile-commands-dir=build', -- Path to compile_commands.json
		},
		filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
		root_dir = require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
	} },
	{ "cssls" },
	{ "golangci_lint_ls" },
	{ "gopls" },
	{ "lua_ls" },
	{ "rust_analyzer" },
	{ "ts_ls" },
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end
