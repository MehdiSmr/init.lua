-- Compat shim: vim.tbl_islist was removed in Neovim 0.13 (renamed to vim.islist
-- in 0.10). packer.nvim still calls the old name, so restore it before loading.
if vim.tbl_islist == nil and vim.islist ~= nil then
  vim.tbl_islist = vim.islist
end

require("mehdi")
vim.lsp.enable('luals')

