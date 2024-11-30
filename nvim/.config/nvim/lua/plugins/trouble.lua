return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    {
      '<leader>dd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Show diagnostics (Trouble)',
    },
    {
      '<leader>dD',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Show buffer diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Toggle symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Show LSP definitions/references (Trouble)',
    },
    {
      '<leader>dQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Toggle quickfix list (Trouble)',
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
