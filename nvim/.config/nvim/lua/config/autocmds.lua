-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Spell check markdown files',
  pattern = 'md',
  group = vim.api.nvim_create_augroup('markdown-group', { clear = true }),
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en_uk'
  end,
})
