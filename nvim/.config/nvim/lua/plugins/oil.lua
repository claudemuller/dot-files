return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = {
    { "nvim-mini/mini.icons",       opts = {} },
    { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },
  opts = {},
  config = function()
    require("oil").setup({
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true,
        show_preview = true,
      },
      float = {
        padding = 2,
        max_width = 0.75,
        max_height = 0.75,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        preview_split = "auto",
      },
      keymaps = {
        ["<ESC>"] = { "actions.close", mode = "n" },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      },
    })

    -- TODO: doesn't quite work
    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype ~= "oil" then
          return
        end

        local oil = require("oil")
        local entry = require("oil").get_cursor_entry()

        if entry and entry.type == "file" then
          oil.open_preview()
        else
          oil.close_preview()
        end
      end,
    })

    vim.keymap.set("n", "-", ":Oil --float<CR>", { silent = true })
  end
}
