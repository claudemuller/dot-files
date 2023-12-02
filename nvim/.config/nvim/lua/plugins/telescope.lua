-----------------------------------------------------------------------
-- [[ telescope.nvim config ]]
-----------------------------------------------------------------------

-- Fuzzy Finder (files, lsp, etc)
-- See `:help telescope.txt`
return {
    "nvim-telescope/telescope.nvim",
    --branch = "0.1.4",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
   },
  },
  run = function()
    pcall(require("telescope").load_extension, "fzf")
  end,
}

