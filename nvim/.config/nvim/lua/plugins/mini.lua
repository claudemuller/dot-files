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
    require("mini.cursorword").setup({
      priority = 1000,
    })

    local function set_cursorword_hl()
      vim.api.nvim_set_hl(0, "MiniCursorword", { underline = false, bg = "#444444" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false, bg = "#444444" })
      vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { bg = "#2e2e2e", fg = "#5c5f62", bold = true })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_cursorword_hl,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        set_cursorword_hl()
      end,
    })

    set_cursorword_hl()
  end,
}
