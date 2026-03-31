vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function()
    if vim.fn.search("{{") ~= 0 then
      vim.bo.filetype = "gohtmltmpl"
    end
  end,
})
