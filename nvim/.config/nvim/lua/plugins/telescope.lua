-----------------------------------------------------------------------
-- [[ telescope config ]]
-----------------------------------------------------------------------

-- Fuzzy Finder (files, lsp, etc)
-- See `:help telescope.txt`
return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.4",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function()
        local actions = require("telescope.actions")

        return {
            defaults = {
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                    n = {
                        ["q"] = actions.close,
                    },
                },
            },
            on_attach = function(buffer)
                vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles,
                    { desc = "Find recently opened files" })
                vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers,
                    { desc = "Find existing buffers" })
                vim.keymap.set("n", "<leader>/", function()
                    -- You can pass additional configuration to telescope to change theme, layout, etc.
                    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    }))
                end, { desc = "Fuzzily search in current buffer]" })

                vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "Search files" })
                vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Search help" })
                vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string,
                    { desc = "Search current word" })
                vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Search by grep" })
                vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics,
                    { desc = "Search diagnostics" })
                vim.keymap.set("n", "<leader>sr", require("telescope.builtin").registers, { desc = "Search registers" })
            end,
        }
    end,
    init = function()
        pcall(require("telescope").load_extension, "fzf")
    end,
}
