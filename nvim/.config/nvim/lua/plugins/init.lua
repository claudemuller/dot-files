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

  -- {
  --   'pocco81/auto-save.nvim',
  --   config = function()
  --     require('auto-save').setup {
  --       execution_message = {
  --         message = function() -- message to print on save
  --           return ''
  --         end,
  --         dim = 0.18, -- dim the color of `message`
  --         cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  --       },
  --     }
  --   end,
  -- },

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
      { '<leader>fd', ':DiffviewOpen HEAD~2<CR>', desc = 'Diffview with last commit', mode = { 'n', 'v' } },
      { '<leader>fu', ':DiffviewOpen<CR>', desc = 'Diffview with unstaged files', mode = { 'n', 'v' } },
    },
  },
}
