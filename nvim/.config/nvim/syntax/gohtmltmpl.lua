if vim.b.current_syntax then
  return
end

if vim.g.main_syntax == nil then
  vim.g.main_syntax = "html"
end

vim.cmd("runtime! syntax/gotexttmpl.lua")
--vim.cmd("runtime! syntax/html.vim")

vim.b.current_syntax = nil
vim.cmd("syntax cluster htmlPreproc add=gotplAction,goTplComment")
vim.b.current_syntax = "gohtmltmpl"
