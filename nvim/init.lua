local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local tmux = os.getenv('TMUX') -- needed for vim-slime

-- set pythonprog
g.python3_host_prog = '/usr/bin/python'
g.loaded_python_provider = 0

-- Pack Path
cmd 'set packpath-=~/.config/nvim'
cmd 'set packpath-=~/.config/nvim/after'
cmd 'set packpath-=~/.local/share/nvim/site'
cmd 'set packpath-=~/.local/share/nvim/site/after'
cmd 'set packpath-=/etc/xdg/nvim'
cmd 'set packpath-=/etc/xdg/nvim/after'
cmd 'set packpath-=/usr/local/share/nvim/site'
cmd 'set packpath-=/usr/local/share/nvim/site/after'
cmd 'set packpath-=/usr/share/nvim/site'
cmd 'set packpath-=/usr/share/nvim/site/after'
cmd 'set packpath^=~/.config/nvim-nightly'
cmd 'set packpath+=~/.config/nvim-nightly/after'
cmd 'set packpath^=~/.local/share/nvim-nightly/site'
cmd 'set packpath+=~/.local/share/nvim-nightly/site/after'

-- -- Runtime Path
cmd 'set runtimepath-=~/.config/nvim'
cmd 'set runtimepath-=~/.config/nvim/after'
cmd 'set runtimepath-=~/.local/share/nvim/site'
cmd 'set runtimepath-=~/.local/share/nvim/site/after'
cmd 'set runtimepath-=/etc/xdg/nvim'
cmd 'set runtimepath-=/etc/xdg/nvim/after'
cmd 'set runtimepath-=/usr/share/nvim/site'
cmd 'set runtimepath-=/usr/share/nvim/site/after'
cmd 'set runtimepath-=/usr/local/share/nvim/site'
cmd 'set runtimepath-=/usr/local/share/nvim/site/after'
cmd 'set runtimepath+=~/.config/nvim-nightly/after'
cmd 'set runtimepath^=~/.config/nvim-nightly'
cmd 'set runtimepath+=~/.local/share/nvim-nightly/site/after'
cmd 'set runtimepath^=~/.local/share/nvim-nightly/site'

local CONFIG_DIR = os.getenv('HOME') .. '/.config/nvim-nightly'
local LOCAL_DIR = os.getenv('HOME') .. '/.local/share/nvim-nightly'

-- plugins
require ('plugins')
-- lua status line
local lualine = require('lualine')
lualine.theme = 'onedark'
lualine.extensions = { 'fzf' }
lualine.status()

-- ripgrep search command
g.rg_command = 'rg --vimgrep -S'

-- use slime in tmux panes
g.slime_target = "tmux"
g.slime_default_config = {
	socket_name= string.match(tmux, '(.-),'),
	target_pane= ":.1"
}
g.slime_python_ipython = 1

-- remotely control neovim, needed for some vimtex features
-- g.vimtex_compiler_progname = 'nvr'
g.vimtex_view_enabled = false
-- g.vimtex_view_general_viewer = 'mupdf.exe'
-- let g:vimtex_view_general_options
--	\ = '-reuse-instance -forward-search @tex @line @pdf'
-- g.vimtex_view_general_options_latexmk = '-reuse-instance'
g.vimtex_compiler_method = 'latexmk'
-- g.vimtex_compiler_latexmk = { options = [ '-shell-escape' ] }
-- g.vimtex_compiler_latexmk_engines = { _ = '-xelatex' }
g.vimtex_quickfix_mode = 1
g.tex_flavor = 'latex'

local scopes = {o = vim.o, b = vim.bo, w = vim.w}

local function opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
cmd 'colorscheme ayu'
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', indent)
opt('b', 'smartindent', true)
opt('b', 'tabstop', indent)
opt('o', 'hidden', true)
opt('o', 'ignorecase', true)
opt('o', 'joinspaces', false)
opt('o', 'scrolloff', 4)
opt('o', 'shiftround', true)
opt('o', 'sidescrolloff', 8)
opt('o', 'smartcase', true)
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'termguicolors', true)
opt('o', 'wildmode', 'longest:full,full')
opt('w', 'list', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'wrap', false)
opt('o', 'timeoutlen', 250)
opt('o', 'clipboard', 'unnamedplus')
opt('o', 'icm', 'nosplit')

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = ","
g.maplocalleader = ","

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<C-p>', ':Files<cr>')
map('n', '<C-o>', ':Buffer<cr>')
map('n', '<leader>b', ':BLines<cr>')
map('n', '<leader>r', ':Rg<cr>')

-- modify command for plugin commands
vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_s', { noremap = false, silent = false  })
vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_S', { noremap = false, silent = false  })

map('n', '<leader>w', ':w<cr>')
map('n', '<leader>q', ':q<cr>')
-- map('n', '<leader>f', ':%s/\<<c-r><c-w>\>//g<left><left>')
map('n', '<leader>k', ':m-2<cr>==')
map('n', '<leader>j', ':m+<cr>==')

map('n', '<leader>t', ':execute \'bo vs \' . g:todofile <cr>')

map('n', '<leader>n', ':noh<cr>')
map('n', '<leader>c', ':cd %:p:h<cr>')

map('n', '<leader>o', ':Obsess ~/sessions/') --save session
map('n', '<leader>p', ':source ~/sessions/') --restore session

map('v', '<leader>c', ':OSCYank<cr>')

--treesitter config
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable=true}}

--lsp config
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

lsp.clangd.setup{}
lsp.jedi_language_server.setup{}
lsp.texlab.setup{}
lspfuzzy.setup{}

--deoplete notmuch address search
g['deoplete#sources#notmuch#command'] = {'notmuch', 'address', '--format=json', '--deduplicate=address', '*'}

--autopairs config
require('nvim-autopairs').setup({
  pairs_map = {
    ["'"] = "'",
    ['"'] = '"',
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['`'] = '`',
    ['$'] = '$'
  }
})

--oscyank settings
--probably not needed, but may need to override terminal detection for tmux, [see](https://github.com/ojroques/vim-oscyank)

-- g.netrw_browsex_viewer="cmd.exe /C start" --open urls from wsl

-- TODO: fix this stuff
-- if has('wsl') 
-- 	let g:clipboard = { 
-- 				\ 'name': 'wslclipboard', 
-- 				\ 'copy': { 
-- 					\ '+': '/mnt/c/Tools/win32yank-x64/win32yank.exe -i --crlf', 
-- 					\ '*': '/mnt/c/Tools/win32yank-x64/win32yank.exe -i --crlf', 
-- 				\ }, 
-- 				\ 'paste': { 
-- 					\ '+': '/mnt/c/Tools/win32yank-x64/win32yank.exe -o --lf', 
-- 					\ '*': '/mnt/c/Tools/win32yank-x64/win32yank.exe -o --lf', 
-- 				\ }, 
-- 				\ 'cache_enabled': 1, 
-- 				\ } 
-- endif 

-- set markdown preview to work in wsl
g.mkdp_browser = 'wslview'

-- pandoc settings
g['pandoc#biblio#sources'] = 'bclyG'
g['pandoc#completion#bib#mode'] = 'fallback'
g['pandoc#filetypes#pandoc_markdown'] = 0
g['pandoc#filetypes#handled'] = {'pandoc'}
g['pandoc#modules#disabled'] = {"folding"}
-- for autocomplete, use *.bib library files and coc-bibtex


