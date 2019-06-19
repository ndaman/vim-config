call plug#begin('~/AppData/Local/nvim/plugged')

" Switch to coc.nvim completion
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" CocInstall coc-omni
" CocInstall coc-snippets
" CocInstall coc-vimtex
" CocInstall coc-dictionary
" CocInstall coc-tsserver coc-json

" common snippets
Plug 'honza/vim-snippets'

" markdown formatting
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" auto-close parenthesis etc. plugin
Plug 'jiangmiao/auto-pairs'

" fancy start page
Plug 'mhinz/vim-startify'

" fuzzy search, need binary installed separately
" see my custom function later for autocomplete
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" simple project browser
Plug 'scrooloose/nerdtree'

" some git functions, crystalline uses it
Plug 'tpope/vim-fugitive'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" airline looks better to me, but cyrstalline is supposed to be lighter/faster
Plug 'rbong/vim-crystalline'

" Themes
Plug 'ayu-theme/ayu-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'

" commented out bc I'm not using it
" Plug 'tpope/vim-surround'
" vim-surround mapping
"vmap s S

" learn to use before loading
" Plug 'mattn/emmet-vim'

" Autogenerate table of contents
Plug 'ndaman/vim-markdown-toc'

" shortcuts for git add, commit, push, etc.
Plug 'lambdalisue/gina.vim'

" get targets from makefile, good integration with platformio
" need to learn this better
Plug 'neomake/neomake'
" Plugin to fix some directory issues
" Plug 'barafael/neomake-platformio' "doesn't work

" lsdyna syntax and completion
Plug 'gradzikb/vim-lsdyna'

" ripgrep searching
Plug 'jremmen/vim-ripgrep'
let g:rg_command = 'rg --vimgrep -S'

" quickfix reflector for editing the quickfix
Plug 'stefandtw/quickfix-reflector.vim'

" latex integration
Plug 'lervag/vimtex'
" remotely control neovim, needed for some vimtex features
Plug 'mhinz/neovim-remote'
let g:vimtex_compiler_progname = 'nvr'

call plug#end()

filetype plugin on

" set colorscheme
set termguicolors
let ayucolor="dark"
syntax on
colorscheme ayu

"coc.nvim settings
" if hidden is not set, TextEdit might fail
set hidden
" some servers have issues with backup files
set nobackup
set nowritebackup
" better display for messages
set cmdheight=2
" smaller update time for CursorHold
set updatetime=300
" don't give ins-completion messages
set shortmess+=c
" show sign columns
set signcolumn=yes

" use tabe to select autocomplete
function! s:check_back_space() abort
	let col=col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" navigate snippet placeholders with Tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" use enter to accept expandion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" map keyboard for changing windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" let NERDTree take over netrw (default folder navigation)
let g:NERDTreeHijackNetrw=1

" map NERDTree toggle
map <C-b> :NERDTreeToggle<CR>

" custom snippets file
" let g:neosnippet#snippets_directory='~/AppData/Local/nvim/snippets'

" customize markdown toc
nnoremap <C-g> :GenTocGFM<CR>
let g:vmt_auto_update_on_save = 1 
let g:vmt_link = 0
let g:vmt_min_level = 1 
let g:vmt_max_level = 1

" function to convert fzf into relative path
function! MyRelPath(...)
	" full path to fzf file match
	let target = getcwd() . '\' . substitute(a:1, '/', '\', 'g')

	" current directory (not cwd)
	let base = expand('%:p:h')

	let prefix = ""
	while strridx(target, base) != 0
		let base = substitute(base, '\\[^\\]\+$', '', '')
		let prefix = '..' . prefix
	endwhile

	if prefix == ''
		let prefix = '.'
	endif

	let regmatch = substitute(base, '\', '\\\\', 'g')
	execute ':normal! a' . prefix . substitute(target, regmatch, '', '')
endfunction

" More fzf mapping
nnoremap <C-p> :Files<cr>
nnoremap <C-o> :Buffer<cr>

" map relative path completion to <c-f> in edit mode
inoremap <c-f> <c-o>:call fzf#run({'source': 'git ls-files *.jpg *.jpeg *.png *.pdf *.svg *.html *.PNG', 'sink': function('MyRelPath')}) <CR> 

" git mapping 
nnoremap <c-a> :Gina add .<CR> 
nnoremap <c-s> :Gina commit <CR>
nnoremap <c-z> :Gina push <CR>

" map scrolling
nnoremap <Space> <PageDown> 
nnoremap <S-Space> 

" automatically set correct directory
function! OnTabEnter(path)
	if isdirectory(a:path)
		let dirname = a:path
	else
		let dirname = fnamemodify(a:path,":h")
	endif
	execute "tcd ". dirname
endfunction

autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

" set tabs to display smaller
set tabstop=2
set softtabstop=2
set shiftwidth=2

" turn on line numbers
set number

" set colors in crystalline
function! StatusLine(current)
  return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CrystallineInactive#')
        \ . ' %f%h%w%m%r '
        \ . (a:current ? '%#CrystallineFill# %{fugitive#head()} ' : '')
        \ . '%=' . (a:current ? '%#Crystalline# %{&paste?"PASTE ":""}%{&spell?"SPELL ":""}' . crystalline#mode_color() : '')
        \ . ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
endfunction

function! TabLine()
  let l:vimlabel = has("nvim") ?  " NVIM " : " VIM "
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'default'

set showtabline=2
set laststatus=2

" remap digraphs
""inoremap <C-y> <C-k>
" code highlighting for other languages inside markdown
let g:markdown_fenced_languages = ['html', 'css', 'python', 'bash=sh', 'tex']

" replace all span titles
" :%s/<span>\(.*\)<\/span>/----\r## \1/g
nmap <C-t> :%s!<span>\(.*\)</span>!----\r## \1!g<CR>

" shortcuts for aligning tables with tabular
if exists(":Tabularize")
	nnoremap <Leader>a :Tabularize /<bar><cr>
endif

" shortcut to edit init.vim
nnoremap <C-i> :tabedit D:\Sync\Sync\vim-config\init.vim<cr>

" general use shortcuts
let mapleader=","
" save
nnoremap <leader>w :w<cr>
nnoremap <leader>q :wq<cr>
" replace word under cursor
nnoremap <leader>f :%s/\<<c-r><c-w>\>//g<left><left>
" move lines up or down
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==

