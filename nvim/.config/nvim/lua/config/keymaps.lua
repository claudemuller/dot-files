-----------------------------------------------------------------------
-- [[ Keymaps ]]
-----------------------------------------------------------------------

local M = {}

local funcs = require("functions")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<S-u>", ":redo", { silent = true })

vim.keymap.set("v", "<S-j>", "<cmd>:m +1<cr>", { silent = true })
vim.keymap.set("v", "<S-k>", "<cmd>:m -1<cr>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- File operations
vim.keymap.set("n", "<M-s>", "<cmd>:wa<cr>", { desc = "[Ctrl][Meta][S]ave Current File" })

-- Window management
-- vim.keymap.set("n", "<leader>+", "<cmd>:vertical resize +10<cr>", { desc = "Increase Split" })
-- vim.keymap.set("n", "<leader>-", "<cmd>:vertical resize -10<cr>", { desc = "Decrease Split" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- GitSigns
vim.keymap.set('n', "]c", require("gitsigns").next_hunk)
vim.keymap.set('n', "[c", require("gitsigns").preview_hunk)

-- Telescope
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

-- Neotree

-- Dap
vim.keymap.set("n", "<leader>dr", function() require 'dap'.continue() end, { desc = "[D]ebug [R]un" })
vim.keymap.set("n", "<F10>", function() require 'dap'.step_over() end, { desc = "Debug [F10]Step Over" })
vim.keymap.set("n", "<F11>", function() require 'dap'.step_into() end, { desc = "Debug [F11]Step Into" })
vim.keymap.set("n", "<F12>", function() require 'dap'.step_out() end, { desc = "Debug [F12]Step Out" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "[D]ebug Run [L]ast" })
-- nmap("<leader>db", function() require("dap").toggle_breakpoint() end, "[D]ebug Toggle [B]reakpoint")

-- HYdra
--vim.keymap.set("n", "<leader>db", function() require('hydra').spawn("dap-hydra") end, { desc = "[D]e[bug]" })
--vim.keymap.set("n", "<leader>r", function() require('hydra').spawn("run-hydra") end, { desc = "[R]un" })

-- LSP settings.
M.on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.

    --  This function gets run when an LSP connects to a particular buffer.
    local nmap = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

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

-- C/C++
vim.keymap.set("n", "<leader>gc", funcs.switch_c_h, { desc = "[G]o to C/Cpp or H file" })

return M
