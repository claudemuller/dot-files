return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    {
      '<leader>td',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Toggle diagnostics',
    },
    {
      '<leader>tD',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Toggle buffer diagnostics',
    },
    {
      '<leader>ts',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Toggle symbols',
    },
    {
      '<leader>tl',
      -- '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      '<cmd>Trouble lsp_float<cr>',
      desc = 'Toggle LSP definitions/references',
    },
    {
      '<leader>tQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Toggle quickfix list',
    },
    -- {
    --   '<leader>Tt',
    --   function()
    --     local trouble = require 'trouble'
    --
    --     if trouble.is_open() and trouble.mode() == 'symbols' then
    --       trouble.close()
    --     else
    --       trouble.open { mode = 'symbols' }
    --     end
    --   end,
    --   { desc = 'Toggle Symbols' },
    -- },
  },
  opts = {
    focus = true,
    modes = {
      preview_float = {
        mode = 'diagnostics',
        preview = {
          type = 'float',
          relative = 'editor',
          border = 'rounded',
          title = 'Preview',
          title_pos = 'center',
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
      lsp_float = {
        mode = 'lsp',
        focus = true,
        win = {
          position = 'right',
          size = 50,
        },
        preview = {
          type = 'float',
          relative = 'win',
          border = 'rounded',
          title = 'Preview',
          title_pos = 'center',
          position = { 0, -200 },
          size = { width = 150, height = 0.5 },
          zindex = 200,
        },
      },
      preview_split = {
        mode = 'diagnostics',
        preview = {
          type = 'split',
          relative = 'win',
          position = 'right',
          size = 0.3,
        },
      },
    },
  },
}
