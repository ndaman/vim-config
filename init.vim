let g:python3_host_prog = 'D:/Anaconda/envs/py3/python'

call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'mhinz/vim-startify'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'altercation/vim-colors-solarized'
"Plug 'dracula/vim'
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'

Plug 'mattn/emmet-vim'

Plug 'ndaman/vim-markdown-toc'

Plug 'rhysd/nyaovim-popup-tooltip'

Plug 'lambdalisue/gina.vim'

call plug#end()

"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
syntax on
colorscheme gruvbox

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

" workaround for nyaovim's weird argv issue
if exists('g:nyaovim_version')
" delete first arg
	execute '1argd'
" close current buffer
	execute 'bd'
endif

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
