return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  opts = {
    keymap = { preset = "default" },
    completion = {
      documentation = {
        auto_show = true,
      },
      menu = {
        draw = {
          columns = {
            { "label",      "label_description", gap = 1 },
            { "kind_icon",  "kind" },
            { "source_name" },
          },
          treesitter = { "lsp" },
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        show_documenation = false,
      },
    },
  },
  opts_extend = { "sources.default" },
}
