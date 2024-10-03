-----------------------------------------------------------------------
-- [[ nvim-dap config ]]
-----------------------------------------------------------------------

-- Debugger
-- See `:help nvim-dap`
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = 'nvim-neotest/nvim-nio',
    },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.set_log_level 'TRACE'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    local dap_breakpoint = {
      error = {
        text = '🟥',
        texthl = 'LspDiagnosticsSignError',
        linehl = '',
        numhl = '',
      },
      rejected = {
        text = '',
        texthl = 'LspDiagnosticsSignHint',
        linehl = '',
        numhl = '',
      },
      stopped = {
        text = '⭐️',
        texthl = 'LspDiagnosticsSignInformation',
        linehl = 'DiagnosticUnderlineInfo',
        numhl = 'LspDiagnosticsSignInformation',
      },
    }
    vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
    vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
    vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>Dt', dapui.toggle, { desc = '[D]ebug: [T]oggle UI' })
    vim.keymap.set('n', '<leader>Dr', function()
      dapui.open { reset = true }
    end, { desc = '[D]ebug: [R]eset UI' })
    vim.keymap.set('n', '<leader>Dc', dap.continue, { desc = '[D]ebug: Start/[C]ontinue' })
    vim.keymap.set('n', '<F1>', dap.continue, { desc = '[D]ebug: Start/[C]ontinue' })
    vim.keymap.set('n', '<S-F1>', dap.run_last, { desc = '[D]ebug: Run Last' })
    vim.keymap.set('n', '<leader>DT', dap.terminate, { desc = '[D]ebug: [T]erminate' })
    vim.keymap.set('n', '<F12>', dap.terminate, { desc = '[D]ebug: [T]erminate' })
    vim.keymap.set('n', '<leader>Do', dap.step_over, { desc = '[D]ebug: Step [o]ver' })
    vim.keymap.set('n', '<F3>', dap.step_over, { desc = '[D]ebug: Step [o]ver' })
    vim.keymap.set('n', '<leader>Di', dap.step_into, { desc = '[D]ebug: Step [I]nto' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = '[D]ebug: Step [I]nto' })
    vim.keymap.set('n', '<leader>DO', dap.step_out, { desc = '[D]ebug: Step [O]ut' })
    vim.keymap.set('n', '<F4>', dap.step_out, { desc = '[D]ebug: Step [O]ut' })
    vim.keymap.set('n', '<leader>DB', dap.step_back, { desc = '[D]ebug: Step [B]ack' })
    vim.keymap.set('n', '<F5>', dap.step_back, { desc = '[D]ebug: Step [B]ack' })
    vim.keymap.set('n', '<leader>Db', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle [b]reakpoint' })
    vim.keymap.set('n', '<F6>', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle [b]reakpoint' })
    vim.keymap.set('n', '<leader>DB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[D]ebug: Set Conditional [B]reakpoint' })
    vim.keymap.set('n', '<S-F6>', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[D]ebug: Set Conditional [B]reakpoint' })
    vim.keymap.set({ 'n', 'v' }, '<leader>Dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = '[D]ebug: Hover (UI)' })
    vim.keymap.set({ 'n', 'v' }, '<leader>Dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = '[D]ebug: Preview (UI)' })
    vim.keymap.set('n', '<F7>', dap.run_to_cursor, { desc = '[D]ebug: Run To Cursor' })
    vim.keymap.set({ 'n', 'v' }, '<F8>', function()
      dapui.eval(nil, { enter = true })
    end, { desc = '[D]ebug: Evaluate Under Cursor' })

    require('nvim-dap-virtual-text').setup {
      commented = true,
    }

    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '',
          play = 'F1 ',
          step_into = 'F2 󰆹',
          step_over = 'F3 ',
          step_out = 'F4 󰆸',
          step_back = 'F5 ',
          run_last = 'SF1 ',
          terminate = 'F12 ',
          disconnect = '󰇪',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>Ds', dapui.toggle, { desc = '[D]ebug: See last [s]ession result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.launch['dapui_config'] = dapui.open
    -- dap.listeners.before.attach['dapui_config'] = dapui.open

    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Custom lang setups
    -- require('config.dap.python').setup()
    require('config.dap.lua').setup()
    require('config.dap.go').setup()
    -- require('config.dap.java').setup()
    -- require('config.dap.c').setup()
  end,
}
