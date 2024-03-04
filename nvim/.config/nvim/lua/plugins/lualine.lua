-----------------------------------------------------------------------
-- [[ Lualine config ]]
-----------------------------------------------------------------------

-- Set lualine as statusline
-- See `:help lualine`
return {
  'nvim-lualine/lualine.nvim',
  opts = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
}
