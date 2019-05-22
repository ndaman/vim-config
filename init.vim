call plug#begin('~/AppData/Local/nvim/plugged')

" autocomplete with snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" markdown formatting
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" auto-close parenthesis etc. plugin
" disabled because it doesn't seem to work in markdown
" Plug 'rstacruz/vim-closer'

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

Plug 'tpope/vim-surround'

" learn to use before loading
" Plug 'mattn/emmet-vim'

" Autogenerate table of contents
Plug 'ndaman/vim-markdown-toc'

" shortcuts for git add, commit, push, etc.
Plug 'lambdalisue/gina.vim'

" get targets from makefile, good integration with platformio
" need to learn this better
Plug 'neomake/neomake'

call plug#end()

" set colorscheme
set termguicolors
let ayucolor="dark"
syntax on
colorscheme ayu

" map keyboard for changing windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" map keys for deoplete
imap <C-k>	<Plug>(neosnippet_expand_or_jump)
smap <C-k>	<Plug>(neosnippet_expand_or_jump)
xmap <C-k>	<Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
	\ pumvisible() ? "\<C-n>" :
	\ neosnippet#expandable_or_jumpable() ?
	\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" set higher priority for filename completion
call deoplete#custom#source('file', 'rank', 1000)
call deoplete#custom#source('neosnippet', 'rank', 1000)

" let NERDTree take over netrw (default folder navigation)
let g:NERDTreeHijackNetrw=1

" map NERDTree toggle
map <C-b> :NERDTreeToggle<CR>

" custom snippets file
let g:neosnippet#snippets_directory='~/AppData/Local/nvim/snippets'

" customize markdown toc
nnoremap <C-g> :GenTocGFM<CR>
let g:vmt_auto_update_on_save = 1 
let g:vmt_link = 0
let g:vmt_min_level = 1 
let g:vmt_max_level = 1

" function to convert fzf into relative path
function! MyRelPath(...)
	" full path to fzf file match
	let target = getcwd() . '\' . substitute(a:1, '/', '\', '')
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

" map relative path completion to <c-f> in edit mode
inoremap <c-f> <c-o>:call fzf#run({'source': 'git ls-files *.jpg *.jpeg *.png *.pdf *.svg *.html *.PNG', 'sink': function('MyRelPath')}) <CR> 

" git mapping 
nnoremap <c-a> :Gina add .<CR> 
nnoremap <c-s> :Gina commit <CR>
nnoremap <c-z> :Gina push <CR>

" map scrolling
nnoremap <Space> <PageDown> 
nnoremap <S-Space> 

" vim-surround mapping
vmap s S

" automatically set correct directory
function! OnTabEnter(path)
	if isdirectory(a:path)
		let dirname = a:path
	else
		let dirname = fnamemodify(a:path,":h")
	endif
	execute "tcd ". dirname
endfunction()

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
inoremap <C-y> <C-k>

