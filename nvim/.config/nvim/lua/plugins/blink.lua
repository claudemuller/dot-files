return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.fn.expand("~/.snippets"),
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
      },
    },
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
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
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
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
