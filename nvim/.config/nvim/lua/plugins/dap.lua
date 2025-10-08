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
        text = '🛑',
        texthl = 'LspDiagnosticsSignError',
        linehl = '',
        numhl = '',
      },
      rejected = {
        text = '🪲',
        texthl = 'LspDiagnosticsSignHint',
        linehl = '',
        numhl = '',
      },
      stopped = {
        text = '⏸',
        texthl = 'LspDiagnosticsSignInformation',
        linehl = 'DiagnosticUnderlineInfo',
        numhl = 'LspDiagnosticsSignInformation',
      },
    }
    vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
    vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
    vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<S-F5>', dap.run_last, { desc = 'Debug: Run last' })
    vim.keymap.set('n', '<F12>', dap.terminate, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step into' })
    vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'Debug: Step out' })
    vim.keymap.set('n', '<C-F11>', dap.step_back, { desc = 'Debug: Step back' })
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
    vim.keymap.set('n', '<S-F9>', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set conditional breakpoint' })
    vim.keymap.set('n', '<F7>', dap.run_to_cursor, { desc = 'Debug: run to Cursor' })
    vim.keymap.set({ 'n', 'v' }, '<F8>', function()
      dapui.eval(nil, { enter = true })
    end, { desc = 'Debug: Evaluate Under Cursor' })

    vim.keymap.set('n', '<leader>Dt', dapui.toggle, { desc = 'Toggle UI' })
    vim.keymap.set('n', '<localleader>Dr', function()
      dapui.open { reset = true }
    end, { desc = 'Reset UI' })
    -- vim.keymap.set('n', '<leader>Dc', dap.continue, { desc = 'Debug: Start/[C]ontinue' })
    vim.keymap.set({ 'n', 'v' }, '<localleader>Dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Hover (UI)' })
    vim.keymap.set({ 'n', 'v' }, '<localleader>Dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = 'Preview (UI)' })
    vim.keymap.set('n', '<leader>DL', ':DapShowLog<cr>', { desc = 'Show log' })

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
          play = 'F5 ',
          step_into = 'F11 󰆹',
          step_over = 'F10 ',
          step_out = 'S-F11 󰆸',
          step_back = 'C-F11 ',
          run_last = 'S-F5 ',
          terminate = 'F12 ',
          disconnect = '󰇪',
        },
      },
      render = {
        value_formatters = {
          ['uint8_t'] = function(value)
            return tostring(value) -- Convert to decimal
          end,
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>Ds', dapui.toggle, { desc = 'Debug: See last [s]ession result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.launch['dapui_config'] = dapui.open
    -- dap.listeners.before.attach['dapui_config'] = dapui.open

    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Custom lang setups
    -- require('config.dap.python').setup()
    require('config.dap.lua').setup()
    require('config.dap.go').setup()
    -- require('config.dap.rust').setup()
    -- require('config.dap.java').setup()
    require('config.dap.c').setup()

    -- vim.api.nvim_create_autocmd('DirChanged', {
    --   pattern = '*',
    --   callback = function()
    --     local project_nvim_lua = vim.fn.getcwd() .. '/.nvim.lua'
    --     if vim.fn.filereadable(project_nvim_lua) == 1 then
    --       dofile(project_nvim_lua)
    --     end
    --     -- Or load .vscode/launch.json
    --     require('dap.ext.vscode').load_launchjs()
    --   end,
    -- })

    -- Define the layouts you want to switch between
    local layouts = {
      default = {
        elements = {
          'scopes',
          'watches',
          'stacks',
          'breakpoints',
          'repl',
          'console',
        },
        size = 40,
        position = 'left',
      },
      no_watches = {
        elements = {
          'scopes',
          'stacks',
          'breakpoints',
          'repl',
          'console',
        },
        size = 40,
        position = 'left',
      },
    }

    local current_layout = 'default'

    -- Function to toggle between the layouts
    local function toggle_watches_pane()
      if current_layout == 'default' then
        current_layout = 'no_watches'
      else
        current_layout = 'default'
      end
      dapui.setup {
        layouts = { layouts[current_layout] },
      }
      dapui.open()
    end

    -- Setup dap-ui with the initial layout
    dapui.setup {
      layouts = { layouts[current_layout] },
      -- Add other configuration options here
      -- ...
    }

    -- Attach a keymap to your toggle function
    vim.keymap.set('n', '<leader>Dw', toggle_watches_pane, { desc = 'Toggle DAP UI Watches Pane' })
  end,
}
