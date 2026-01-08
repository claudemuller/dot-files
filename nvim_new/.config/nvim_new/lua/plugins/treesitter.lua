return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({
      "bash",
      "c",
      "cpp",
      "diff",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "gotmpl",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonnet",
      "lua",
      "luadoc",
      "luap",
      "markdowm",
      "markdown_inline",
      "odin",
      "python",
      "query",
      "regex",
      "rust",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }):wait(300000)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { "*" },
      callback = function() vim.treesitter.start() end,
    })
  end
}
