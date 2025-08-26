return {
  'OXY2DEV/markview.nvim',
  lazy = false,

  -- For `nvim-treesitter` users.
  priority = 49,

  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  -- },
  config = function()
    local presets = require 'markview.presets'

    require('markview').setup {
      preview = {
        enable = false,
      },
      markdown = {
        horizontal_rules = presets.horizontal_rules.dashed,
        headings = presets.headings.slanted,
      },
    }

    vim.keymap.set('n', '<leader>M', ':Markview splitToggle<cr>', { desc = 'Toggle markdown split view' })
  end,
}
