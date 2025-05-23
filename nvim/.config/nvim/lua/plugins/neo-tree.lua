-----------------------------------------------------------------------
-- [[ NeoTree config ]]
-----------------------------------------------------------------------

-- File tree viewer
-- See `:help neo-tree`
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v3.x',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',
  },
  keys = {
    --{ "<leader>f", desc = "File" },
    { '<leader>fn', ':Neotree toggle<CR>', desc = 'Toggle neotree' },
    { '<leader>fts', ':Neotree document_symbols<CR>', desc = 'Toggel symbol view' },
  },
  config = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

    require('neo-tree').setup {
      sources = {
        'filesystem',
        'document_symbols',
        -- 'buffers',
        -- 'git_status',
      },
      source_selector = {
        winbar = true, -- toggle to show selector on winbar
        statusline = false, -- toggle to show selector on statusline
        show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
        -- of the top visible node when scrolled down.
        tab_labels = { -- falls back to source_name if nil
          filesystem = '  Files ',
          buffers = '  Buffers ',
          git_status = '  Git ',
          diagnostics = ' 裂Diagnostics ',
        },
      },
      default_source = 'filesystem',
      hide_root_node = false,
      retain_hidden_root_indent = false,
      popup_border_style = 'NC', -- "double", "none", "rounded", "shadow", "single" or "solid"
      default_component_configs = {
        indent = {
          indent_marker = '┊',
          last_indent_marker = '└',
        },
      },
      window = {
        mappings = {
          ['<space>'] = false,
          ['<tab>'] = 'toggle_node',
          ['v'] = 'open_vsplit',
          ['z'] = false,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          force_visible_in_empty_folder = false,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            '.git',
            --"node_modules",
          },
          never_show = {
            '.git',
          },
        },
        hijack_netrw_behavior = 'open_current',
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
    }
  end,
  opts = function(_, opts)
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require 'neo-tree.events'
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
  end,
}
