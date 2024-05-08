-----------------------------------------------------------------------
-- [[ NeoTest config ]]
-----------------------------------------------------------------------

-- Test thing
-- See `:help neotest`
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-jest',
    -- 'nvim-neotest/neotest-go',
    '~/repos/3rd-party/neotest-go/',
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
    {
      '<leader>Tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = '[T]est [L]ast',
    },
    {
      '<leader>Td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = '[T]est [D]ebug',
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
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

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
          ignore_file_types = { 'python', 'vim', 'lua', 'go', 'typescript', 'jest' },
        },
      },
      icons = {
        expanded = '',
        child_prefix = '',
        child_indent = '',
        final_child_prefix = '',
        non_collapsible = '',
        collapsed = '',

        passed = '',
        running = '',
        failed = '',
        unknown = '',
      },
    }
  end,
}
