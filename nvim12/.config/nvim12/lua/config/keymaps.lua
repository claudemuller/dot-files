-- Keymaps

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set("n", "gr", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, client in ipairs(clients) do
		if client.server_capabilities.referencesProvider then
			vim.lsp.buf.references()
			break -- Only use first capable client
		end
	end

	-- vim.cmd("vertical copen")
	vim.cmd("copen")
	-- Focus on qf win
	vim.cmd("wincmd j")
	-- Move qf win to right of editor
	-- vim.cmd("wincmd L")
end, { desc = "LSP: Find References" })

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		local line = vim.api.nvim_win_get_cursor(0)[1] - 1
		local diags = vim.diagnostic.get(0, { lnum = line })
		if #diags > 0 then
			vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
		end
	end,
})

