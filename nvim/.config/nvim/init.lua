-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
end

local function get_config(name)
    return string.format('require("config/%s")', name)
end

require("packer").startup(function(use)
    -- Package manager
    use("wbthomason/packer.nvim")

    use({ -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            "j-hui/fidget.nvim",

            -- Additional lua configuration, makes nvim stuff amazing
            "folke/neodev.nvim",
        },
    })

    use({ -- Autocompletion
        "hrsh7th/nvim-cmp",
        requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    })

    use({ -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
    })

    use({ -- Additional text objects via treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })

    use({ "RRethy/vim-illuminate", config = get_config("illuminate") })

    -- Git related plugins
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })
    use("nvim-lualine/lualine.nvim") -- Fancier c
    use({
      "lukas-reineke/indent-blankline.nvim",
      opts = {
        char = "┊",
        show_trailing_blankline_indent = false,
      }
    }) -- Add indentation guides even on blank lines
    use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
    use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

    use({ "windwp/nvim-autopairs", config = get_config("nvim-autopairs") })

    -- Fuzzy Finder (files, lsp, etc)
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = get_config("neotree"),
    })

    use('ray-x/go.nvim')
    -- use('ray-x/guihua.lua')

    -- use({
    --     "mfussenegger/nvim-dap",
    --     opt = true,
    --     event = "BufReadPre",
    --     module = { "dap" },
    --     wants = { "nvim-dap-virtual-text", "nvim-dap-ui" },
    --     requires = {
    --         "theHamsta/nvim-dap-virtual-text",
    --         "rcarriga/nvim-dap-ui",
    --         "nvim-telescope/telescope-dap.nvim",
    --         { "leoluz/nvim-dap-go", module = "dap-go" },
    --         { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    --     },
    --     config = function()
    --         require("config.dap").setup()
    --     end,
    -- })

    -- use({
    --     "anuvyklack/hydra.nvim",
    --     requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
    --     config = function()
    --       require("config.hydra")
    --     end
    -- })

    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, "custom.plugins")
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require("packer").sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print("==================================")
    print("    Plugins are being installed")
    print("    Wait until Packer completes,")
    print("       then restart nvim")
    print("==================================")
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
    group = packer_group,
    pattern = vim.fn.expand("$MYVIMRC"),
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd([[colorscheme catppuccin-mocha]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.lsp.set_log_level("off")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- vim.keymap.set("v", "<S-j>", "<cmd>:m +1<cr>", { silent = true })
-- vim.keymap.set("v", "<S-k>", "<cmd>:m -1<cr>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

require('go').setup()
require("go.format").goimport() -- goimport + gofmt

-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "catppuccin",
        component_separators = "|",
        section_separators = "",
    },
})

-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
-- require("indent_blankline").setup({
--     char = "┊",
--     show_trailing_blankline_indent = false,
-- })

-- Gitsigns
-- See `:help gitsigns.txt`
require("gitsigns").setup({
    signs = {
        add = { text = "✚" },
        change = { text = "" },
        delete = { text = "✖" },
        topdelete = { text = "✖" },
        changedelete = { text = "" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
    },
})

vim.keymap.set('n', "]c", require("gitsigns").next_hunk)
vim.keymap.set('n', "[c", require("gitsigns").preview_hunk)

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
})

vim.keymap.set("n", "<M-s>", "<cmd>:wa<cr>", { desc = "[Ctrl][Meta][S]ave Current File" })
vim.keymap.set("n", "<leader>+", "<cmd>:vertical resize +10<cr>", { desc = "Increase Split" })
vim.keymap.set("n", "<leader>-", "<cmd>:vertical resize -10<cr>", { desc = "Decrease Split" })

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").registers, { desc = "[S]earch [R]egisters" })

vim.keymap.set("n", "<leader>nt", ":NeoTreeShow<CR>", { desc = "[N]eo[T]ree" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "typescript", "vim" }, -- "help",

    highlight = { enable = true },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmapl = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        nmap(keys, func, desc)
    end

    nmapl("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmapl("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmapl("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmapl("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmapl("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmapl("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmapl("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmapl("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmapl("K", vim.lsp.buf.hover, "Hover Documentation")
    nmapl("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmapl("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmapl("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmapl("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmapl("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

-- [[ Dap ]]
nmap("<leader>dr", function() require 'dap'.continue() end, "[D]ebug [R]un")
nmap("<F10>", function() require 'dap'.step_over() end, "Debug [F10]Step Over")
nmap("<F11>", function() require 'dap'.step_into() end, "Debug [F11]Step Into")
nmap("<F12>", function() require 'dap'.step_out() end, "Debug [F12]Step Out")
nmap("<leader>dl", function() require("dap").run_last() end, "[D]ebug Run [L]ast")
-- nmap("<leader>db", function() require("dap").toggle_breakpoint() end, "[D]ebug Toggle [B]reakpoint")

-- [[ HYdra ]]
vim.keymap.set("n", "<leader>db", function() require('hydra').spawn("dap-hydra") end, { desc = "[D]e[bug]" })
vim.keymap.set("n", "<leader>r", function() require('hydra').spawn("run-hydra") end, { desc = "[R]un" })

-- [[ C/C++ Stuff ]]
local switch_c_h = function()
    local curFile = vim.fn.expand('%')
    local ext = string.match(curFile, ".(%w+)$")
    local name = string.sub(curFile, 0, string.len(curFile) - string.len(ext))

    if ext == "h" or ext == "hpp" then
        if (vim.fn.filereadable(name .. "c") > 0) then
            vim.cmd(":e " .. name .. "c")
        elseif (vim.fn.filereadable(name .. "cpp") > 0) then
            vim.cmd(":e " .. name .. "cpp")
        end
    end

    if ext == "c" or ext == "cpp" then
        if (vim.fn.filereadable(name .. "h") > 0) then
            vim.cmd(":e " .. name .. "h")
        elseif (vim.fn.filereadable(name .. "hpp") > 0) then
            vim.cmd(":e " .. name .. "hpp")
        end
    end
end
vim.keymap.set("n", "<leader>gc", switch_c_h, { desc = "[G]o to C/Cpp or H file" })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},

    -- sumneko_lua = {
    --   Lua = {
    --     workspace = { checkThirdParty = false },
    --     telemetry = { enable = false },
    --   },
    -- },
}

-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})

-- Turn on lsp status information
require("fidget").setup()

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})

require('autocmd')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
