-----------------------------------------------------------------------
-- [[ General config ]]
-----------------------------------------------------------------------

return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
  },

  'pocco81/auto-save.nvim',

  -- `opts = {}` is equivalent to:
  --    require('Comment').setup({})
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  --	{
  --		"nvim-treesitter/nvim-treesitter-textobjects",
  --		dependencies = { "nvim-treesitter" },
  --	},
  -- "MunifTanjim/nui.nvim",

  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>fd', ':DiffthisOpen HEAD~2<CR>', desc = 'Diffthis with last commit', mode = { 'n', 'v' } },
      { '<leader>fu', ':DiffthisOpen<CR>', desc = 'Diffthis with unstaged files', mode = { 'n', 'v' } },
    },
  },
}
