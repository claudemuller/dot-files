return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = true,
    format_on_save = {
      timeout_ms = 1500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      cpp = { "clang-format" },
      css = { "prettier" },
      go = { "gofmt", "goimports" },
      html = { "prettier" },
      javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "isort", "black" },
      sql = { "sqlfmt" },
      typescript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
      yaml = { "yamlfmt" },
    },
    lang_to_formatters = {
      json = { "jq" },
    },
    formatters = {
      black = {
        prepend_args = { "-l", 120 },
      },
      prettier = {
        prepend_args = {
          "--print-width ",
          120,
          "--tab-width",
          4,
          "--arrow-parens",
          "avoid",
          "--single-quote",
          "false",
        },
      },
      eslint_d = {},
      sqlfmt = {
        command = "sqlfmt",
        args = {},
        stdin = true,
      },
    },
  },
}
