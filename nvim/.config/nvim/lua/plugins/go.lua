-----------------------------------------------------------------------
-- [[ Go config ]]
-----------------------------------------------------------------------

-- Go stuff
-- See `:help go`
return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  -- keys = {
  --   { '<leader>Tf', ':GoTestFunc<CR>', desc = '[T]est [f]unction' },
  --   { '<leader>TF', ':GoTestFile<CR>', desc = '[T]est [F]ile' },
  --   { '<leader>Tp', ':GoTestPkg<CR>', desc = '[T]est [p]ackage' },
  -- },
  -- init = function()
  -- require('go').setup()
  -- require('go.format').goimport() -- goimport + gofmt
  -- vim.cmd 'GoInstallBinaries'
  -- end,
  event = { 'CmdlineEnter' },
  ft = {
    'go',
    'gomod',
  },
  build = ':lua require("go.install").update_all_sync()',
}
