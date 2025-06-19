-----------------------------------------------------------------------
-- [[ Neovim Theme ]]
-----------------------------------------------------------------------
return {
  -- 'folke/tokyonight.nvim',
  -- 'navarasu/onedark.nvim',
  -- 'EdenEast/nightfox.nvim',
  -- 'rebelot/kanagawa.nvim',
  'thesimonho/kanagawa-paper.nvim',
  -- "eldritch-theme/eldritch.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- require('kanagawa').setup {
    --   undercurl = true, -- enable undercurls
    --   commentStyle = { italic = true },
    --   functionStyle = {},
    --   keywordStyle = { italic = true },
    --   statementStyle = { bold = true },
    --   theme = 'lotus', -- Load "wave" theme
    -- }

    -- require('onedark').setup {
    --   style = 'darker',
    -- }
    -- require('onedark').load()

    -- Load the colorscheme here
    -- vim.cmd.colorscheme 'duskfox'
    vim.cmd.colorscheme 'kanagawa-paper-ink'
    -- vim.cmd.colorscheme 'kanagawa-dragon'

    -- You can configure highlights by doing something like
    -- vim.cmd.hi 'Comment gui=none'
  end,
}
