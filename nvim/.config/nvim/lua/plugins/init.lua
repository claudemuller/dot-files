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

  -- `opts = {}` is equivalent to:
  --    require('Comment').setup({})
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

  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>fd', ':DiffviewOpen HEAD~2<CR>', desc = 'Diffview with last commit', mode = { 'n', 'v' } },
      { '<leader>fu', ':DiffviewOpen<CR>', desc = 'Diffview with unstaged files', mode = { 'n', 'v' } },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}
  },
}
