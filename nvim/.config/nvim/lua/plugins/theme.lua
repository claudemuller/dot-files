-----------------------------------------------------------------------
-- [[ Neovim Theme ]]
-----------------------------------------------------------------------

return {
  -- 'folke/tokyonight.nvim',
  'navarasu/onedark.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'darker',
    }
    require('onedark').load()

    -- Load the colorscheme here
    -- vim.cmd.colorscheme 'onedark'
    --
    -- -- You can configure highlights by doing something like
    -- vim.cmd.hi 'Comment gui=none'
  end,
}
