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
  pattern = '*.md',
  group = vim.api.nvim_create_augroup('markdown-group', { clear = true }),
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en_uk'
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Convert keybindings cheatsheet to PDF on save',
  pattern = 'keybindings.md',
  group = vim.api.nvim_create_augroup('notes-group', { clear = true }),
  callback = function()
    local path = vim.api.nvim_buf_get_name(0)
    local fname = vim.fn.fnamemodify(path, ':t:r')
    local dir = vim.fn.fnamemodify(path, ':p:h')
    local mdfile = ('%s/%s.md'):format(dir, fname)
    local cssfile = ('%s/%s.css.html'):format(dir, fname)
    local out_path = ('%s/%s.html'):format(dir, fname)
    local job_cmd = {
      'pandoc',
      '-o',
      out_path,
      '--include-in-header',
      cssfile,
      mdfile,
    }
    local job_opts = {
      on_stdout = function(_, data, _)
        print('Pandoc output:', data)
      end,
      on_stderr = function(_, data, _)
        print('Pandoc error:', data)
      end,
    }
    vim.fn.jobstart(job_cmd, job_opts)
  end,
})
