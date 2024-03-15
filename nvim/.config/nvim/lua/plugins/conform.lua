-- [[ Conform config ]]

-- Autoformatting management
-- See `:help confirm`
return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofumpt' },
      -- Conform will run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { { 'prettierd', 'prettier' } },
    },
    lang_to_formatters = {
      json = { 'jq' },
    },
    formatters = {
      black = {
        prepend_args = { '-l', 120 },
      },
      prettier = {
        prepend_args = { '--print-width ', 120 },
      },
    },
  },
}
