-- [[ Load Config ]]
require 'config'

-- [[ Load Keymaps ]]
require 'config.keymaps'

-- [[ Load Autocmds ]]
require 'config.autocmds'

-- [[ Bootstrap Lazy Plugin Manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Load Plugins ]]
require('lazy').setup {
  -- Import plugins
  spec = {
    { import = 'plugins' },
  },

  defaults = {
    -- lazy = true,
  },

  install = {
    colorscheme = { 'folke/tokyonight.nvim' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
