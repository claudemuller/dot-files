return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    -- statusline ---------------------------------------------------------------------------------
    local statusline = require("mini.statusline")
    statusline.setup({})
  end
}
