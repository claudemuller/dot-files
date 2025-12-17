-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local fn = require 'functions'

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
  pattern = 'markdown',
  group = vim.api.nvim_create_augroup('markdown-group', { clear = true }),
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en_gb'
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

vim.api.nvim_create_autocmd('FocusLost', {
  desc = 'Auto save all buffers when Vim loses focus',
  group = vim.api.nvim_create_augroup('saving-group', { clear = true }),
  callback = fn.save_all_buffers,
})

vim.api.nvim_create_autocmd('LspProgress', {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), 'info', {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == 'end' and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- Load GLSL plugin for .vert files
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--   group = vim.api.nvim_create_augroup('GLSLFiletype', { clear = true }),
--   pattern = { '*.vs', '*.fs' },
--   callback = function()
--     vim.bo.filetype = 'glsl'
--   end,
-- })

-- vim.api.nvim_create_autocmd('CursorMovedI', { -- CursorMoved for all cursor movements
--   desc = '',
--   group = vim.api.nvim_create_augroup('typing-group', { clear = true }),
--   callback = function()
--     vim.fn.jobstart 'ffplay -v 0 -nodisp -autoexit ~/temp/typewriter-key.mp3'
--   end,
-- })

-- Go formatting
-- local format_sync_grp = vim.api.nvim_create_augroup('goimports', {})
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.go',
--   callback = function()
--     require('go.format').goimports()
--     vim.defer_fn(function()
--       vim.cmd 'GoToggleInlay'
--     end, 100)
--   end,
--   group = format_sync_grp,

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'c', 'cpp', 'objc', 'objcpp' },
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local root = vim.fs.find({ 'compile_commands.json', '.git' }, { upward = true })[1]
--     print(root)
--     if root then
--       root = vim.fn.fnamemodify(root, ':h')
--       vim.lsp.start {
--         name = 'ccls',
--         cmd = { 'ccls' },
--         root_dir = root,
--         filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
--         init_options = {
--           compilationDatabaseDirectory = '.',
--           index = { threads = 0 },
--           clang = { extraArgs = { '-std=c11', '-std=c++17' } },
--         },
--         -- attach the current buffer
--         bufnr = bufnr,
--       }
--     end
--   end,
-- })
