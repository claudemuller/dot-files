-- [[ Conform config ]]

-- Autoformatting management
-- See `:help confirm`
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  -- Everything in opts will be passed to setup()
  opts = {
    notify_on_error = true,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      -- go = { 'imports' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      -- Conform will run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      yaml = { 'yamlfmt' },
    },
    lang_to_formatters = {
      json = { 'jq' },
    },
    formatters = {
      black = {
        prepend_args = { '-l', 120 },
      },
      prettier = {
        prepend_args = {
          '--print-width ',
          120,
          '--tab-width',
          4,
          '--arrow-parens',
          'avoid',
        },
      },
    },
  },
}
