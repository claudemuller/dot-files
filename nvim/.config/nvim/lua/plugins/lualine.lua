-----------------------------------------------------------------------
-- [[ Lualine config ]]
-----------------------------------------------------------------------

-- Set lualine as statusline
-- See `:help lualine`
return {
  'nvim-lualine/lualine.nvim',
  opts = function(_, opts)
    local kanagawa_paper = require 'lualine.themes.kanagawa-paper-ink'

    opts.icons_enabled = true
    opts.theme = kanagawa_paper -- 'tokyonight'
    opts.component_separators = '|'
    opts.section_separators = ''
    opts.sections = {
      lualine_c = {
        {
          'filename',
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
    }

    local trouble = require 'trouble'
    local symbols = trouble.statusline {
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = 'lualine_c_normal',
    }

    table.insert(opts.sections.lualine_c, {
      symbols.get,
      cond = symbols.has,
    })
  end,
}
