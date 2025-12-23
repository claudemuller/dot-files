-----------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------

-- nvim-lspconfig
vim.pack.add({ "http://github.com/neovim/nvim-lspconfig" })

-- mason
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim", "https://github.com/mason-org/mason.nvim" })

-- neo-tree
vim.pack.add({
	"http://github.com/nvim-lua/plenary.nvim",
	"http://github.com/nvim-tree/nvim-web-devicons",
	"http://github.com/MunifTanjim/nui.nvim",
	--"http://github.com/3rd/image.nvim",
	{ src = "http://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
})
require("neo-tree").setup({
	vim.keymap.set("n", "<leader>fn", ":Neotree toggle<CR>", { desc = "Toggle neotree" } )
    -- { '<leader>fts', ':Neotree document_symbols<CR>', desc = 'Toggel symbol view' },
})

-- telescope
vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })
require("telescope").setup()

-- comments
vim.pack.add({ "https://github.com/numToStr/Comment.nvim" })
require("Comment").setup()

-- todo comments
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/folke/todo-comments.nvim",
    })

    require("todo-comments").setup({
      signs = true,
    })
  end,
})

-- retro-term
-- vim.pack.add({ "https://github.com/echasnovski/mini.nvim", "http://github.com/claudemuller/retro-term.nvim" })
-- require("retro-term").setup({})

vim.pack.add({ "https://github.com/kdheepak/monochrome.nvim" })
vim.pack.add({ "https://github.com/dzfrias/noir.nvim" })
vim.cmd("colorscheme noir")
