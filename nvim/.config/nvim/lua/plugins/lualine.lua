-----------------------------------------------------------------------
-- [[ lualine config ]]
-----------------------------------------------------------------------

-- Set lualine as statusline
-- See `:help lualine.txt`
return {
    "nvim-lualine/lualine.nvim",
    opts = {
        icons_enabled = false,
        -- theme = "catppuccin",
        theme = 'tokyonight',
        component_separators = "|",
        section_separators = "",
    },
}
