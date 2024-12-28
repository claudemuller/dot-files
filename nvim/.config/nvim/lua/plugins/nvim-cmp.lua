-----------------------------------------------------------------------
-- [[ Nvim-Cmp config ]]
-----------------------------------------------------------------------

-- Autocompletion
-- See `:help nvim-cmp`
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  lazy = false,
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- dependencies = { 'saadparwaiz1/cmp_luasnip' },
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      config = function()
        require('luasnip.loaders.from_lua').load { paths = { '~/.snippets' } }
      end,
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    'rafamadriz/friendly-snippets',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {
      -- Extend with framework snippets
      -- luasnip.filetype_extend('ruby', { 'rails' }),

      -- will exclude all javascript snippets
      -- require('luasnip.loaders.from_vscode').load {
      --   exclude = { 'javascript' },
      -- },
    }

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Disable up and down keys to get used to c-n and c-p
        ['<up>'] = {},
        ['<down>'] = {},

        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping.confirm { select = true },

        -- Only show snippets for substring.
        ['<C-x>'] = function()
          cmp.complete {
            config = {
              sources = {
                { name = 'luasnip' }, -- Only show snippets
              },
            },
          }
        end,

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'nvim_lua' },
      }, {
        { name = 'buffer' },
      }),
    }
  end,
}
-- return {
--   'saghen/blink.cmp',
--   lazy = false, -- lazy loading handled internally
--   -- optional: provides snippets for the snippet source
--   dependencies = 'rafamadriz/friendly-snippets',
--
--   -- use a release tag to download pre-built binaries
--   version = 'v0.*',
--   -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
--   -- build = 'cargo build --release',
--   -- If you use nix, you can build from source using latest nightly rust with:
--   -- build = 'nix run .#build-plugin',
--
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     -- 'default' for mappings similar to built-in completion
--     -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
--     -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
--     -- see the "default configuration" section below for full documentation on how to define
--     -- your own keymap.
--     keymap = { preset = 'default' },
--
--     appearance = {
--       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
--       -- Useful for when your theme doesn't support blink.cmp
--       -- will be removed in a future release
--       use_nvim_cmp_as_default = true,
--       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--       -- Adjusts spacing to ensure icons are aligned
--       nerd_font_variant = 'mono',
--     },
--
--     -- default list of enabled providers defined so that you can extend it
--     -- elsewhere in your config, without redefining it, via `opts_extend`
--     sources = {
--       completion = {
--         enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
--       },
--     },
--
--     -- experimental auto-brackets support
--     -- completion = { accept = { auto_brackets = { enabled = true } } }
--
--     -- experimental signature help support
--     -- signature = { enabled = true }
--   },
--   -- allows extending the enabled_providers array elsewhere in your config
--   -- without having to redefine it
--   opts_extend = { 'sources.completion.enabled_providers' },
-- }
