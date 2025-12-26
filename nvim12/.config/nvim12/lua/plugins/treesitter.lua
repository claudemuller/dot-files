vim.pack.add({
	-- "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = 'main',
		build = ":TSUpdate",
	},
})

local ts = require("nvim-treesitter")

-- ts.install({
-- 	'bash',
-- 	'c',
-- 	'cpp',
-- 	'diff',
-- 	'go',
-- 	'gomod',
-- 	'gowork',
-- 	'gosum',
-- 	'gotmpl',
-- 	'html',
-- 	'javascript',
-- 	'jsdoc',
-- 	'json',
-- 	'jsonc',
-- 	'lua',
-- 	'luadoc',
-- 	'luap',
-- 	'markdowm',
-- 	'markdown_inline',
-- 	'odin',
-- 	'python',
-- 	'query',
-- 	'regex',
-- 	'rust',
-- 	'toml',
-- 	'tsx',
-- 	'typescript',
-- 	'vim',
-- 	'vimdoc',
-- 	'yaml',
-- }):wait(30000)

---@type fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?
local install_parser_and_enable_features = function(bufnr, lang)
  -- Try to start the parser install for the language.
  local ok, task = pcall(ts.install, { lang }, { summary = true })
  if not ok then return end

  -- Wait for the installation to finish (up to 10 seconds).
  task:wait(10000)

  -- Enable syntax highlighting for the buffer
  ok, _ = pcall(vim.treesitter.start, bufnr, lang)
  if not ok then return end

  -- Enable other features as needed.

  -- Enable indentation based on treesitter for the buffer.
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

  -- Enable folding based on treesitter for the buffer
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

 -- Highlight
    pcall(vim.treesitter.start, bufnr, lang)

   -- Indent
    local ok, indentexpr = pcall(require, "nvim-treesitter.indent")
    if ok then
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter.indent'()"
    end

    -- Incremental selection
    local ok, inc_sel = pcall(require, "nvim-treesitter.incremental_selection")
    if ok then
        inc_sel.enable()
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gnn", ":lua require'nvim-treesitter.incremental_selection'.init_selection()<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "grn", ":lua require'nvim-treesitter.incremental_selection'.node_incremental()<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "grc", ":lua require'nvim-treesitter.incremental_selection'.scope_incremental()<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "grm", ":lua require'nvim-treesitter.incremental_selection'.node_decremental()<CR>", { noremap = true, silent = true })
    end
end

-- Install missing parsers on file open.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('ui.treesitter', { clear = true }),
  pattern = { '*' },
  callback = install_parser_and_enable_features
})
