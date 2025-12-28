-----------------------------------------------------------------------
-- [[ Noice config ]]
-----------------------------------------------------------------------

-- Better UI
-- See `:help noice.txt`
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- {
    --   'rcarriga/nvim-notify',
    --   opts = {
    --     top_down = false,
    --   },
    -- },
  },
  -- keys = {
  --   {
  --     '<leader><BS>',
  --     function()
  --       require('noice').cmd 'dismiss'
  --     end,
  --     desc = 'Noice All',
  --   },
  -- },
  config = function()
    require("noice").setup({
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      notify = {
        position = {
          row = "50%",
          col = "50%",
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
        },
        documentation = {
          view = "hover",
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    })
  end,
}
