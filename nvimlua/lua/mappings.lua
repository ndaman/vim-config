local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }

--Remap space as leader key
map({ "n", "v" }, ",", "<Nop>", { silent = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- map keyboard for changing windows
map( "n", "<C-h>", "<C-w>h", default_options)
map( "n", "<C-j>", "<C-w>j", default_options)
map( "n", "<C-k>", "<C-w>k", default_options)
map( "n", "<C-l>", "<C-w>l", default_options)

-- telescope mapping
map( "n", "<C-p>", function()
	require("telescope.builtin").find_files()
end, default_options)
map( "n", "<C-o>", function()
	require('telescope.builtin').buffers()
end, default_options)
map( "n", "<leader>r", function()
	require('telescope.builtin').live_grep()
end, default_options)
map( "n", "<space>f", function()
  require('telescope').extensions.file_browser.file_browser()
end, default_options)

-- sniprun mappings
map( "v", "<leader>c", '<Plug>SnipRun', default_options)
map( "n", "<leader>c", '<Plug>SnipRunOperator', default_options)
map( "n", "<leader>cc", '<Plug>SnipRun', default_options)

-- save
map( "n", "<leader>w", ":w<cr>", default_options)
map( "n", "<leader>q", ":q<cr>", default_options)
map( "n", "<leader>f", ":%s/\\<<c-r><c-w>\\>//g<left><left>", default_options)
map( "n", "<leader>k", ":m-2<cr>==", default_options)
map( "n", "<leader>j", ":m+<cr>==", default_options)

-- other
map( "n", "<leader>n", ":noh<cr>", expr_options)
map( "n", "<leader>cd", ":cd %:p:h<cr>", expr_options)
map( "v", "<leader>y", ":OSCYank<cr>", expr_options)


