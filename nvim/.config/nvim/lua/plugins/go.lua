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
  keys = {
    --   { '<leader>Tf', ':GoTestFunc<CR>', desc = '[T]est [f]unction' },
    --   { '<leader>TF', ':GoTestFile<CR>', desc = '[T]est [F]ile' },
    --   { '<leader>Tp', ':GoTestPkg<CR>', desc = '[T]est [p]ackage' },
    { '<leader>cgc', ':GoCmt<CR>', desc = '[C]ode [G]enerate Function [C]omment' },
    { '<leader>cgt', ':GoAddTag<CR>', desc = '[C]ode [G]enerate [T]ags' },
    { '<leader>crt', ':GoRmTag<CR>', desc = '[C]ode [R]emove [T]ags' },
    { '<leader>cfs', ':GoFillStruct<CR>', desc = '[C]ode [F]ill [S]truct Fields' },
    { '<leader>cfS', ':GoFillSelect<CR>', desc = '[C]ode [F]ill [S]elect' },
    { '<leader>cfe', ':GoIfErr<CR>', desc = '[C]ode [F]ill If/[E]rr' },
    { '<leader>cgm', ':GoMockGen<CR>', desc = '[C]ode [G]enerate [M]ocks for Current File' },
    { '<leader>ct', ':GoModTidy<CR>', desc = '[C]ode [T]idy' },
    -- { '<leader>cd', 'zy:GoDoc <C-r>z<CR>', desc = '[C]ode Go[D]ocs Under Cursor', mode = 'v' },
    -- { '<leader>cs', ':GoPkgOutline<CR>', desc = '[C]ode [S]ymbols' },
  },
  init = function()
    require('go').setup()
    require('go.format').goimport() -- goimport + gofmt
    vim.cmd 'GoInstallBinaries'
  end,
  event = { 'CmdlineEnter' },
  ft = {
    'go',
    'gomod',
  },
  build = ':lua require("go.install").update_all_sync()',
}
