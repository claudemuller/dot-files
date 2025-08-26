return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false,

    -- For `nvim-treesitter` users.
    priority = 49,

    -- For blink.cmp's completion
    -- source
    -- dependencies = {
    --     "saghen/blink.cmp"
    -- },
  },
  config = function()
    local presets = require 'markview.presets'

    require('markview').setup {
      markdown = {
        horizontal_rules = presets.horizontal_rules.dashed,
        headings = presets.headings.slanted,
      },
    }
  end,
}
