local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local tmux = os.getenv('TMUX') -- needed for vim-slime

-- set pythonprog
g.python3_host_prog = '/usr/bin/python'
g.loaded_python_provider = 0

-- plugins
require ('plugins')
local cmp = require'cmp'

-- ripgrep search command
g.rg_command = 'rg --vimgrep -S'

-- use slime in tmux panes
-- not using slime anymore
--g.slime_target = "tmux"
--g.slime_paste_file = "$HOME/.slime_paste"
--g.slime_cell_delimiter = '###'
--g.slime_default_config = {
--	socket_name= "default",
--	target_pane= ":0.0"
--}
--g.slime_python_ipython = 1

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
--open folds by default
opt('w', 'foldlevel', 99)

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = ","
g.maplocalleader = ","

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<C-p>', ':Files<cr>')
map('n', '<C-o>', ':Buffer<cr>')
map('n', '<leader>b', ':BLines<cr>')
map('n', '<leader>r', ':Rg<cr>')

--slime mappings
map('n', '<leader>cc', '<Plug>SlimeSendCell<cr>')
map('n', '<leader>cp', '<Plug>SlimeSendParagraph<cr>')
map('n', '<leader>ci', '<Plug>SlimeConfig<cr>')

map('n', '<leader>w', ':w<cr>')
map('n', '<leader>q', ':q<cr>')
map('n', '<leader>k', ':m-2<cr>==')
map('n', '<leader>j', ':m+<cr>==')

map('n', '<leader>n', ':noh<cr>')
map('n', '<leader>c', ':cd %:p:h<cr>')

map('n', '<leader>o', ':Obsess ~/sessions/') --save session
map('n', '<leader>p', ':source ~/sessions/') --restore session

map('v', '<leader>c', ':OSCYank<cr>')

--treesitter config
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable=true}}

--lsp fuzzy config
local lspfuzzy = require 'lspfuzzy'
lspfuzzy.setup{}

--lsp settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end 

--nvim cmp setup
cmp.setup({
  snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'pandoc_references' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- setup individual language servers
local servers = { 'clangd', 'texlab', 'jedi_language_server' }
for _, lsp in ipairs{servers} do 
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

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

-- pandoc settings
g['pandoc#biblio#sources'] = 'bclyG'
g['pandoc#completion#bib#mode'] = 'fallback'
g['pandoc#filetypes#pandoc_markdown'] = 0
g['pandoc#filetypes#handled'] = {'pandoc'}
g['pandoc#modules#disabled'] = {"folding"}

-- custom fzf function to complete email addresses in notmuch
map('n', '<leader>mm', '<cmd>lua require("tools").email_complete()<cr>')

-- configure hop to work like vim-sneak
-- vimwiki settings
vim.g.vimwiki_list = {{path='~/vimwiki/', syntax='markdown', ext='.wiki'}}
vim.g.vimwiki_global_ext = 0

--catpuccino
local catppuccino = require("catppuccino")
catppuccino.setup({
  colorscheme = "dark_catppuccino",
  term_colors = true,
  styles = {
    comments="italic",
    functions="NONE",
    keywords="NONE",
    strings="NONE",
    variables="NONE",
  },
  integrations = {
    hop = true,
  }
})
vim.cmd[[colorscheme catppuccino]]

--onedark
--require('onedark').setup()

--neoterm
map('n', '<leader>tf', ':TREPLSendFile<cr>')
map('n', '<leader>tl', ':TREPLSendLine<cr>')
