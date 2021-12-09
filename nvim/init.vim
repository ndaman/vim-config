"let g:python3_host_prog='/home/nick/miniconda3/bin/python'
call plug#begin()
"lsp plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

"snippets 
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'
" For ultisnips users.
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'

"editor
Plug 'junegunn/fzf.vim'
Plug 'ggandor/lightspeed.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'jpalardy/vim-slime'
Plug 'kassio/neoterm'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-obsession'
Plug 'mhinz/neovim-remote'
Plug 'ojroques/vim-oscyank'

"lsp 
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'jc-doyle/cmp-pandoc-references'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'hrsh7th/vim-vsnip'

" themes and syntax)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'ayu-theme/ayu-vim'
Plug 'elementx54/moosefw_vim'
Plug 'lervag/vimtex'
Plug 'catppuccin/nvim'
Plug 'ful1e5/onedark.nvim'

"email
Plug 'felipec/notmuch-vim'

call plug#end()

" setup lualine
lua << END 
require'lualine'.setup{
  options = { 
    theme = catpuccin,
    icons_enabled = true
  }
}
END 

" lsp setup
set completeopt=menu,menuone,preview
lua << EOF
local cmp = require'cmp'
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['texlab'].setup {
  capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
require'lspconfig'.vimls.setup {
  capabilities = capabilities
}
require'lspconfig'.pyright.setup {
  capabilities = capabilities
}
--require'lspconfig'.jedi_language_server.setup {
--  capabilities = capabilities
--}
EOF

" regular settings

let g:rg_command = 'rg --vimgrep -S'

let g:vimtex_view_enabled = 0
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_quickfix_mode = 1
let g:tex_flavor = 'latex'

set expandtab
set shiftwidth=2
set smartindent
set tabstop=2
set hidden
set ignorecase
set scrolloff=8
set shiftround
set sidescrolloff=8
set smartcase
set splitbelow
set splitright
set termguicolors
set wildmode="longest:full,full"
set list
set number
set relativenumber
set nowrap
set timeoutlen=250
set clipboard+=unnamedplus
set inc='nosplit'
set foldlevel=99

" mappings
let mapleader = ","
let maplocalleader = ","

" map keyboard for changing windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" More fzf mapping
nnoremap <C-p> :Files<cr>
nnoremap <C-o> :Buffer<cr>
" fuzzy search for lines in file
nnoremap <leader>b :BLines<cr>
" fuzzy search for word in buffer
nnoremap <leader>r :Rg<cr>

"slime mappings
nnoremap <leader>cc <Plug>SlimeSendCell<cr>
nnoremap <leader>cp <Plug>SlimeSendParagraph<cr>
nnoremap <leader>ci <Plug>SlimeConfig<cr>

" code highlighting for other languages inside markdown
let g:markdown_fenced_languages = ['html', 'css', 'python', 'bash=sh', 'tex']

" auto-replace some common items needed after converting tex to md with pandoc
nmap <C-t> :%s!<span>\(.*\)</span>!----\r## \1!e <bar> %s/\\(/`\\(/e <bar> %s/\\)/\\)`/e <bar> %s/\\\[/`\\\[/e <bar> %s/\\\]/\\\]`/e <CR>

" save
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>f :%s/\<<c-r><c-w>\>//g<left><left>
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==

" other
nnoremap <leader>n :noh<cr>
nnoremap <leader>c :cd %:p:h<cr>
vnoremap <leader>y :OSCYank<cr>

" treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
EOF

"lsp fuzzy config
lua require('lspfuzzy').setup {}

"autopairs config
lua <<EOF
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
EOF

" pandoc settings
let g:pandoc#biblio#sources = 'bclyG'
let g:pandoc#completion#bib#mode = 'fallback'
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#filetypes#handled = ["pandoc"]
let g:pandoc#modules#disabled = ["folding"]

" vimwiki settings
let g:vimwiki_list = [{'path':'~/vimwiki/', 'syntax':'markdown', 'ext':'.wiki'}]
let g:vimwiki_global_ext = 0

"catpuccino
lua <<EOF
local catppuccino = require("catppuccin")
catppuccino.setup({
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
vim.cmd[[colorscheme catppuccin]]
EOF

"neoterm
nnoremap <leader>tf :TREPLSendFile<cr>
nnoremap <leader>tl :TREPLSendLine<cr>

"notmuch settings
let g:notmuch_folders = [ 
  \ [ 'all unread', 'tag:inbox and tag:unread'],
  \ [ 'fall 21 new', 'tag:inbox date:08-2021..today'],
  \ [ 'research', 'tag:research'],
  \ [ 'homework', 'tag:homework']]
let g:notmuch_custom_search_maps = {
      \ 't':  'search_tag("+to-do -inbox")',
      \ 'h':  'search_tag("+homework")',
      \ 'a':  'search_tag("+archive -inbox -unread")',
      \ 'd':  'search_tag("+deleted -inbox -unread")',
      \ 'e':  'search_tag("+research")'
      \}
let g:notmuch_custom_show_maps= {
      \ 't':  'search_tag("+to-do -inbox")',
      \ 'h':  'search_tag("+homework")',
      \ 'a':  'search_tag("+archive -inbox -unread")',
      \ 'd':  'search_tag("+deleted -inbox -unread")',
      \ 'e':  'search_tag("+research")'
      \}
"let g:notmuch_reader = 'neomutt -f %s'
let g:notmuch_sendmail = 'sendmail'
