return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
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
    },
    build = function()
      require("blink.cmp").build():pwait()
    end,
    opts = {
      keymap = {
        preset = "none",
        ["<C-n>"] = { "show", "select_next", "snippet_forward", "fallback" },
        ["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-y>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },
      completion = {
        documentation = {
          auto_show = true,
        },
        menu = {
          auto_show = false,
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
        -- window = {
        --   show_documenation = false,
        -- },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "rust" },
    },
    -- opts_extend = { "sources.default" },
  },
}
