return {
  "nvim-mini/mini.nvim",
  version = "*",
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

    -- Icons --------------------------------------------------------------------------------------
    require("mini.icons").setup()

    -- Statusline ---------------------------------------------------------------------------------
    require("mini.statusline").setup()

    -- Pairs --------------------------------------------------------------------------------------
    require("mini.pairs").setup()

    -- Surround -----------------------------------------------------------------------------------
    require("mini.surround").setup()

    -- Cursorword ---------------------------------------------------------------------------------
    require("mini.cursorword").setup()
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual", italic = true })
    vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual", italic = true })
  end,
}
