-- [[ Load Config ]]
require 'config'

-- [[ Load Keymaps ]]
require 'config.keymaps'

-- [[ Load Autocmds ]]
require 'config.autocmds'

-- [[ Bootstrap Lazy Plugin Manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
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
