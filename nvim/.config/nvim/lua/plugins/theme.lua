-----------------------------------------------------------------------
-- [[ Neovim Theme ]]
-----------------------------------------------------------------------
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

return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.base16').setup {
      palette = {
        base00 = '#120f09',
        base01 = '#1e1812',
        base02 = '#35291d',
        base03 = '#66553f',
        base04 = '#a28662',
        base05 = '#c0a179',
        base06 = '#d6b891',
        base07 = '#292016',
        base08 = '#887254',
        base09 = '#d6b891',
        base0A = '#c0a179',
        base0B = '#927a60',
        base0C = '#a28662',
        base0D = '#d6b891',
        base0E = '#a28662',
        base0F = '#887254',
      },
      use_cterm = true,
      plugins = {
        default = false,
        ['echasnovski/mini.nvim'] = true,
      },
    }
  end,
}
