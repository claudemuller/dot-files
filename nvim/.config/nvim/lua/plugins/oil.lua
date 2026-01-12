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
        preview_split = "left",
      },
      keymaps = {
        ["<ESC>"] = { "actions.close", mode = "n" },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = function()
        require("oil").open_preview()
      end,
    })

    vim.keymap.set("n", "-", ":Oil --float<CR>", { silent = true })
  end
}
