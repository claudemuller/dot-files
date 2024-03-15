-----------------------------------------------------------------------
-- [[ Neogit config ]]
-----------------------------------------------------------------------

-- Git manager
-- See `:help neogit`
return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  -- vim.keymap.set('n', '<leader>GP', ':Git push<CR>', { desc = 'Git push' })
  -- vim.keymap.set('n', '<leader>Gp', ':Git pull<CR>', { desc = 'Git pull' })
  -- vim.keymap.set('n', '<leader>Gc', ':Git commit<CR>', { desc = 'Git commit' })
  -- vim.keymap.set('n', '<leader>Gl', ':Telescope git_commits<CR>', { desc = 'Git log' })
  -- vim.keymap.set('n', '<leader>GS', ':Telescope git_status<CR>', { desc = 'Git status' })
  -- vim.keymap.set('n', '<leader>Gt', ':Telescope git_stash<CR>', { desc = 'Git stash' })
  keys = {
    {
      '<leader>Gt',
      function()
        require('neogit').open { kind = 'split' }
      end,
      desc = 'Toggle Neo[G]it',
    },
    {
      '<leader>Gc',
      function()
        require('neogit').open { 'commit' }
      end,
      desc = '[G]it [c]ommit dialog',
    },
  },
  config = true,
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
}
