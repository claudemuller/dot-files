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
    keys = {
      { '<leader>gs', ':Git<cr>', desc = 'Status', mode = { 'n', 'v' } },
      { '<leader>gc', ':Git commit<cr>', desc = 'Commit', mode = { 'n', 'v' } },
      { '<leader>gp', ':Git pull<cr>', desc = 'Pull', mode = { 'n', 'v' } },
      { '<leader>gP', ':Git push<cr>', desc = 'Push', mode = { 'n', 'v' } },
      { '<leader>gll', ':Gllog<cr>', desc = 'Log', mode = { 'n', 'v' } },

      { '<leader>gdh', ':Gdiff :0<cr>', desc = 'Hunk', mode = { 'n', 'v' } },
      { '<leader>gdm', ':Gvdiffsplit master<cr>', desc = 'With master', mode = { 'n', 'v' } },

      { '<leader>gC', ':Git mergetool<cr>', desc = 'Show merge conflicts', mode = { 'n', 'v' } },
      { '<leader>gR', ':Gvdiffsplit!<cr>', desc = 'Resolve conflicts', mode = { 'n', 'v' } },

      { '<leader>gdT', ':diffget //3<cr>', desc = 'Accept theirs', mode = { 'n', 'v' } },
      { '<leader>gdM', ':diffget //2<cr>', desc = 'Accept mine', mode = { 'n', 'v' } },
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

  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gdl', ':DiffviewOpen HEAD~2<CR>', desc = 'With last commit', mode = { 'n', 'v' } },
      { '<leader>gdu', ':DiffviewOpen<CR>', desc = 'With unstaged files', mode = { 'n', 'v' } },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}
  },

  {
    'vhyrro/luarocks.nvim',
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { 'magick' },
    },
  },

  {
    'leoluz/nvim-dap-go',
    keys = {
      { '<leader>Dn', ':lua require("dap-go").debug_test()<cr>', desc = 'Nearest test', mode = { 'n' } },
      { '<leader>Dl', ':lua require("dap-go").debug_last_test()<cr>', desc = 'Last test', mode = { 'n' } },
    },
  },

  -- {
  --   'stevearc/aerial.nvim',
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  -- },

  { 'folke/neodev.nvim', opts = {} },

  { 'towolf/vim-helm' },

  -- {
  --   'tris203/precognition.nvim',
  --   -- keys = {
  --   --   { '<leader>htp', ':lua require("precognition").toggle()<cr>', desc = '[H]ints Toggle [P]recognition', mode = { 'n' } },
  --   -- },
  --   config = {
  --     -- startVisible = true,
  --     -- showBlankVirtLine = true,
  --     -- hints = {
  --     --      Caret = { text = "^", prio = 2 },
  --     --      Dollar = { text = "$", prio = 1 },
  --     --      MatchingPair = { text = "%", prio = 5 },
  --     --      Zero = { text = "0", prio = 1 },
  --     --      w = { text = "w", prio = 10 },
  --     --      b = { text = "b", prio = 9 },
  --     --      e = { text = "e", prio = 8 },
  --     --      W = { text = "W", prio = 7 },
  --     --      B = { text = "B", prio = 6 },
  --     --      E = { text = "E", prio = 5 },
  --     -- },
  --     -- gutterHints = {
  --     --     -- prio is not currently used for gutter hints
  --     --     G = { text = "G", prio = 1 },
  --     --     gg = { text = "gg", prio = 1 },
  --     --     PrevParagraph = { text = "{", prio = 1 },
  --     --     NextParagraph = { text = "}", prio = 1 },
  --     -- },
  --   },
  -- },
}
