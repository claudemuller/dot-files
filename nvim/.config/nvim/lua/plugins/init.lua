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
      { '<leader>gs', ':Git<cr>', desc = '[G]it [S]tatus', mode = { 'n', 'v' } },
      { '<leader>gc', ':Git commit<cr>', desc = '[G]it [C]ommit', mode = { 'n', 'v' } },
      { '<leader>gp', ':Git pull<cr>', desc = '[G]it [P]ull', mode = { 'n', 'v' } },
      { '<leader>gP', ':Git push<cr>', desc = '[G]it [P]ush', mode = { 'n', 'v' } },
      { '<leader>gll', ':Gllog<cr>', desc = '[G]it [L]og', mode = { 'n', 'v' } },
      { '<leader>gP', ':Git push<cr>', desc = '[G]it [P]ush', mode = { 'n', 'v' } },
      { '<leader>gdh', ':Gdiff :0<cr>', desc = '[G]it [D]iff [H]unk', mode = { 'n', 'v' } },
      { '<leader>gdm', ':Gvdiffsplit master<cr>', desc = '[G]it [D]iff with [M]aster', mode = { 'n', 'v' } },
      { '<leader>gC', ':Git mergetool<cr>', desc = '[G]it Show Merge [C]onflicts', mode = { 'n', 'v' } },
      { '<leader>gR', ':Gvdiffsplit!<cr>', desc = '[G]it [R]esolve Conflicts', mode = { 'n', 'v' } },
      { 'gdt', ':diffget //3<cr>', desc = '[G]it [D]iff Get Theirs', mode = { 'n', 'v' } },
      { 'gdm', ':diffget //2<cr>', desc = '[G]it [D]iff Get Mine', mode = { 'n', 'v' } },
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
      { '<leader>gdl', ':DiffviewOpen HEAD~2<CR>', desc = '[G]it [D]iff with [L]ast commit', mode = { 'n', 'v' } },
      { '<leader>gdu', ':DiffviewOpen<CR>', desc = '[G]it [D]iff with [U]nstaged files', mode = { 'n', 'v' } },
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
      { '<leader>Dn', ':lua require("dap-go").debug_test()<cr>', desc = '[D]ebug [N]earest Test', mode = { 'n' } },
      { '<leader>Dl', ':lua require("dap-go").debug_last_test()<cr>', desc = '[D]ebug [L]ast Test', mode = { 'n' } },
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
