return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    -- AI
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Git ----------------------------------------------------------------------------------------
    -- TODO: READ THE DOCS
    require("mini.git").setup()

    -- Diff ---------------------------------------------------------------------------------------
    vim.go.number = false
    require("mini.diff").setup({
      mappings = {
        reset = 'gr',
      },
    })

    -- Icons --------------------------------------------------------------------------------------
    -- TODO: check config and redundant plugins
    require("mini.icons").setup()

    -- Statusline ---------------------------------------------------------------------------------
    require("mini.statusline").setup()

    -- Pairs --------------------------------------------------------------------------------------
    require("mini.pairs").setup()

    -- Surround -----------------------------------------------------------------------------------
    require("mini.surround").setup()
  end
}
