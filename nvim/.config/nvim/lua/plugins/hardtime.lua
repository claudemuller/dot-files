return {
  'm4xshen/hardtime.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    max_time = 750,
    disable_mouse = false,
    restricted_keys = {
      ['<C-N>'] = {},
      ['<C-P>'] = {},
    },
  },
}
