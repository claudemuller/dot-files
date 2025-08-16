-----------------------------------------------------------------------
-- [[ Neovim Theme ]]
-----------------------------------------------------------------------

return {
  'claudemuller/retro-term.nvim',
  dependencies = { 'echasnovski/mini.nvim' },
  lazy = false,
  priority = 1000,
  opts = {},
  dev = true,
  -- config = function()
  --   require('retro-term').setup { variant = 'base' } -- "muted" | "original" | "base"
  -- end,
}

-- return {
--   'folke/tokyonight.nvim',
--   -- 'navarasu/onedark.nvim',
--   -- 'EdenEast/nightfox.nvim',
--   -- 'rebelot/kanagawa.nvim',
--   -- 'thesimonho/kanagawa-paper.nvim',
--   -- "eldritch-theme/eldritch.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     -- require('kanagawa').setup {
--     --   undercurl = true, -- enable undercurls
--     --   commentStyle = { italic = true },
--     --   functionStyle = {},
--     --   keywordStyle = { italic = true },
--     --   statementStyle = { bold = true },
--     --   theme = 'wave', -- Load "wave" theme
--     --   background = { -- map the value of 'background' option to a theme
--     --     dark = 'wave', -- try "dragon" !
--     --     light = 'lotus',
--     --   },
--     -- }
--
--     -- require('onedark').setup {
--     --   style = 'darker',
--     -- }
--     -- require('onedark').load()
--
--     vim.cmd.colorscheme 'tokyonight-night'
--
--     -- vim.cmd.colorscheme 'duskfox'
--
--     -- vim.cmd 'colorscheme kanagawa-lotus'
--     -- vim.cmd("colorscheme kanagawa-dragon")
--     -- vim.cmd("colorscheme kanagawa-lotus")
--
--     -- vim.cmd.colorscheme 'kanagawa-paper-ink'
--     -- vim.cmd.colorscheme 'kanagawa-paper-canvas'
--
--     -- You can configure highlights by doing something like
--     -- vim.cmd.hi 'Comment gui=none'
--   end,
-- }
