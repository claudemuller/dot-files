return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    {
      '<leader>td',
      '<cmd>Trouble diagnostics_split toggle<cr>',
      desc = 'Toggle diagnostics',
    },
    {
      '<leader>tD',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Toggle buffer diagnostics',
    },
    {
      '<leader>ts',
      '<cmd>Trouble symbols toggle focus=true win={size=60}<cr>',
      desc = 'Toggle symbols',
    },
    {
      '<leader>tl',
      '<cmd>Trouble lsp_split toggle<cr>',
      desc = 'Toggle LSP definitions/references',
    },
    {
      '<leader>tQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Toggle quickfix list',
    },
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
      lsp_split = {
        mode = 'lsp',
        focus = true,
        win = {
          position = 'right',
          size = 80,
        },
        preview = {
          type = 'float',
          relative = 'win',
          border = 'rounded',
          title = 'Preview',
          title_pos = 'center',
          position = { 0, -230 },
          size = { width = 150, height = 0.8 },
          zindex = 200,
        },
      },
      diagnostics_split = {
        mode = 'diagnostics',
        focus = true,
        win = {
          position = 'right',
          size = 80,
        },
        preview = {
          type = 'float',
          relative = 'win',
          border = 'rounded',
          title = 'Preview',
          title_pos = 'center',
          position = { 0, -230 },
          size = { width = 150, height = 0.8 },
          zindex = 200,
        },
      },
    },
  },
}
