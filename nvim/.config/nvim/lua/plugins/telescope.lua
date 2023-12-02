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
            end,
        }
    end,
    keys = {
        { "<leader>?",       "<cmd>Telescope oldfiles<CR>",    { desc = "Find recently opened files" } },
        { "<leader><space>", "<cmd>Telescope buffers<CR>",     { desc = "Find existing buffers" } },
        -- {"n", "<leader>/", function()
        --     -- You can pass additional configuration to telescope to change theme, layout, etc.
        --     require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        --         winblend = 10,
        --         previewer = false,
        --     }))
        -- end, { desc = "Fuzzily search in current buffer]" })
        { "<leader>ff",      "<cmd>Telescope find_files<CR>",  { desc = "Search files" } },
        { "<leader>sh",      "<cmd>Telescope help_tags<CR>",   { desc = "Search help" } },
        { "<leader>sw",      "<cmd>Telescope grep_string<CR>", { desc = "Search current word" } },
        { "<leader>sg",      "<cmd>Telescope live_grep<CR>",   { desc = "Search by grep" } },
        { "<leader>sd",      "<cmd>Telescope diagnostics<CR>", { desc = "Search diagnostics" } },
        { "<leader>sr",      "<cmd>Telescope registers<CR>",   { desc = "Search registers" } },
    },
    init = function()
        pcall(require("telescope").load_extension, "fzf")
    end,
}
