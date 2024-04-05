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
    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
    },
  },
}
