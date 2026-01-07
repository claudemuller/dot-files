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
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '<filetype>' },
      callback = function() vim.treesitter.start() end,
    })
  end
}
