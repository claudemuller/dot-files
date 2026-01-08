vim.cmd [[
  aunmenu PopUp
  anoremenu PopUp.Inspect             <cmd>Inspect<CR>
  amenu PopUp.-1-                     <NOP>
  anoremenu PopUp.Definition          <cmd>lua vim.lsp.buf.definition()<CR>
  anoremenu PopUp.References          <cmd>Trouble lsp_references<CR>
  anoremenu PopUp.Back                <C-t>
  amenu PopUp.-2-                     <NOP>
  anoremenu PopUp.URL                 gx
]]

local group = vim.api.nvim_create_augroup("nvim_popupmenu", { clear = true })

vim.api.nvim_create_autocmd("MenuPopup", {
  pattern = "*",
  group = group,
  desc = "Context Menu Setup",
  callback = function()
    vim.cmd [[
      amenu disable PopUp.Definition
      amenu disable PopUp.References
      amenu disable PopUp.URL
    ]]

    if vim.lsp.get_clients({ bufnr = 0 })[1] then
      vim.cmd [[
        amenu enable PopUp.Definition
        amenu enable PopUp.References
      ]]
    end

    local urls = require("vim.ui")._get_urls()
    if vim.startswith(urls[1], "http") then
      vim.cmd [[
        amenu enable PopUp.URL
      ]]
    end
  end
})
