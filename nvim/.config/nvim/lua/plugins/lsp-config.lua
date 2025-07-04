-----------------------------------------------------------------------
-- [[ Nvim LSP config ]]
-----------------------------------------------------------------------

-- LSP Config & Plugins
-- See `:help ?`
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    { 'mason-org/mason-lspconfig.nvim', dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
    } },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'nvim-telescope/telescope-dap.nvim',

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- Brief Aside: **What is LSP?**
    --
    -- LSP is an acronym you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully

    -- and elegantly composed help section, `:help lsp-vs-treesitter`
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local builtin = require 'telescope.builtin'

        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc .. ' (LSP)' })
        end

        map('gd', builtin.lsp_definitions, 'Goto definition')
        map('gz', function()
          vim.cmd 'vsplit'
          vim.lsp.buf.definition()
          vim.cmd 'zt'
        end, 'Goto definition in vertical split')
        map('gr', builtin.lsp_references, 'Goto references')
        map('gi', builtin.lsp_implementations, 'Goto implementation')
        --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('<leader>cd', builtin.lsp_type_definitions, 'Definition')

        map('<leader>sz', function()
          local symbol = vim.fn.input 'Symbol (default: under cursor): '
          if symbol == '' or symbol == nil then
            symbol = vim.fn.expand '<cword>'
          end
          builtin.lsp_workspace_symbols { query = symbol }
        end, '')
        map('<leader>ss', builtin.lsp_document_symbols, 'Document symbols')
        map('<leader>sS', builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols')

        map('<leader>lr', ':LspRestart<cr>', 'Restart')

        map('<leader>cr', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')

        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { 0 })
        end
      end,
    })

    require('telescope').load_extension 'dap'

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      asm_lsp = {},
      bashls = {},
      clangd = {
        -- capabilities = { signatureHelpProvider = false },
      },
      codelldb = {},
      cssls = {},
      cucumber_language_server = {},
      dockerls = {},
      docker_compose_language_service = {},
      golangci_lint_ls = {},
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
            semanticTokens = true,
          },
        },
      },
      html = {},
      helm_ls = {
        filetypes = { 'helm' },
        cmd = { 'helm_ls', 'serve' },
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = 'yaml-language-server',
            },
          },
        },
      },
      intelephense = {
        root_dir = function(fname)
          return vim.loop.cwd()
        end,
      },
      jdtls = {},
      jsonls = {},
      lemminx = {},
      ltex = {
        settings = {
          filetypes = { 'markdown', 'text' },
          flags = { debounce_text_changes = 300 },
          language = 'en-GB',
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      marksman = {},
      ols = {
        -- settings = {
        --   checker_args = '-strict-style',
        --   collections = {
        --     { name = 'shared', path = vim.fn.expand '$HOME/odin-lib' },
        --   },
        -- },
      },
      pyright = {},
      -- rust_analyzer = {
      --   diagnostics = {
      --     enable = true,
      --   },
      --   cargo = {
      --     allFeatures = true,
      --     loadOutDirsFromCheck = true,
      --     runBuildScripts = true,
      --   },
      --   -- Add clippy lints for Rust.
      --   checkOnSave = {
      --     allFeatures = true,
      --     command = 'clippy',
      --     extraArgs = { '--no-deps' },
      --   },
      --   procMacro = {
      --     enable = true,
      --     ignored = {
      --       ['async-trait'] = { 'async_trait' },
      --       ['napi-derive'] = { 'napi' },
      --       ['async-recursion'] = { 'async_recursion' },
      --     },
      --   },
      -- },
      starlark_rust = {},
      sqlls = {},
      taplo = {},
      ts_ls = {},
      yamlls = {},
    }

    -- Ensure the servers and tools above are installed
    -- require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    local lspconfig = require 'lspconfig'

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}

          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

          lspconfig[server_name].setup(server)
        end,
      },
    }
  end,
}
