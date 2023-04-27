-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- map leader to comma
vim.g.mapleader = ","
vim.g.maplocalleader = ","
-- set clipboard for wsl
-- to use win32yank needs to be installed in path
-- see https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
if vim.fn.has("wsl") == 1 then
  vim.opt.clipboard = "unnamedplus"
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("Yank", { clear = true }),
    callback = function()
      vim.fn.system("win32yank.exe", vim.fn.getreg('"'))
    end,
  })
end
