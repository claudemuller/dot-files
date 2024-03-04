-----------------------------------------------------------------------
-- [[ NeoTest config ]]
-----------------------------------------------------------------------

-- Test thing
-- See `:help neotest`
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/neotest-go',
    -- 'nvim-neotest/neotest-rust',
    'nvim-neotest/neotest-vim-test',
  },
  keys = {
    {
      '<leader>Tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[T]est File',
    },
    {
      '<leader>TT',
      function()
        require('neotest').run.run(vim.loop.cwd())
      end,
      desc = 'Run All [T]est Files',
    },
    {
      '<leader>Tr',
      function()
        require('neotest').run.run()
      end,
      desc = '[T]est Nea[r]est',
    },
    -- ['<leader>td'] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", 'Debug Test' },
    {
      '<leader>Ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle [T]est [s]ummary',
    },
    {
      '<leader>To',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'Show [T]est [o]utput',
    },
    {
      '<leader>TO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Toggle [T]est [O]utput Panel',
    },
    {
      '<leader>TS',
      function()
        require('neotest').run.stop()
      end,
      desc = '[T]est [S]top',
    },
  },
  opts = {
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        if require('lazyvim.util').has 'trouble.nvim' then
          require('trouble').open { mode = 'quickfix', focus = false }
        else
          vim.cmd 'copen'
        end
      end,
    },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
        require 'neotest-plenary',
        require 'neotest-jest',
        require 'neotest-go',
        -- require 'neotest-rust',
        require 'neotest-vim-test' {
          ignore_file_types = { 'python', 'vim', 'lua' },
        },
      },
    }
  end,
}
