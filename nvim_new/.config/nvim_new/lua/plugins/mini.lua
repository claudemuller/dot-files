return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    -- git ----------------------------------------------------------------------------------------
    -- TODO: check config and redundant plugins
    local git = require("mini.git")
    git.setup()

    -- diff ---------------------------------------------------------------------------------------
    -- TODO: check config and redundant plugins
    local diff = require("mini.diff")
    diff.setup()

    -- icons --------------------------------------------------------------------------------------
    -- TODO: check config and redundant plugins
    local icons = require("mini.icons")
    icons.setup()

    -- statusline ---------------------------------------------------------------------------------
    local statusline = require("mini.statusline")
    statusline.setup()
  end
}
