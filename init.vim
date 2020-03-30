call plug#begin('~/AppData/Local/nvim/plugged')

" Switch to coc.nvim completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'justinmk/vim-sneak'

" auto-close parenthesis etc. plugin
Plug 'jiangmiao/auto-pairs'
" add $ to auto-close for latex work
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", '$':'$', '$$':'$$'}

" fancy start page
Plug 'mhinz/vim-startify'

" fuzzy search, need binary installed separately
" see my custom function later for autocomplete
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
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

" get targets from makefile, good integration with platformio
" need to learn this better
Plug 'neomake/neomake'
" Plugin to fix some directory issues
" Plug 'barafael/neomake-platformio' "doesn't work

" lsdyna syntax and completion
Plug 'ndaman/vim-lsdyna'

" ripgrep searching
Plug 'jremmen/vim-ripgrep'
let g:rg_command = 'rg --vimgrep -S'

" quickfix reflector for editing the quickfix
Plug 'stefandtw/quickfix-reflector.vim'

" easily interact with tmux
Plug 'jpalardy/vim-slime'
let g:slime_target = "tmux"

" latex integration
Plug 'lervag/vimtex'
" remotely control neovim, needed for some vimtex features
Plug 'mhinz/neovim-remote'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
	\ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = { 'options' : [ '-shell-escape' ] }
let g:vimtex_compiler_latexmk_engines = { '_' : '-xelatex' }
let g:vimtex_quickfix_mode = 1

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
set cmdheight=1
" smaller update time for CursorHold
set updatetime=300
" don't give ins-completion messages
set shortmess+=c
" show sign columns
set signcolumn=yes

" use tab to select autocomplete
function! s:check_back_space() abort
	let col=col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap',['snippets-expand-jump',''])\<CR>" :
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
" ignore filetypes in NERDTree
let g:NERDTreeIgnore=['\.fdb_latexmk$','\.fls$', '\.pdf$','\.aux$','\.gz$','\.nav$','\.out$','\.snm$','\.md5$']

" customize markdown toc
nnoremap <C-g> :GenTocGFM<CR>
let g:vmt_auto_update_on_save = 1 
let g:vmt_link = 0
let g:vmt_min_level = 1 
let g:vmt_max_level = 1

" function to convert fzf into relative path
function! MyRelPath(...)
	" path from git root to file
	let relpath = substitute(a:1, '/', '\', 'g')
	" find root folder
	let rootfolder = substitute(relpath, '\\.*', '', '')
	" full path of cwd
	let target = getcwd() 
	" git root folder
	let gitroot = substitute(target, rootfolder . '.*', '', '')
	let target = gitroot . relpath

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
	let winpath = substitute(target, regmatch, '', '')
	let winpath = substitute(winpath, ' ', '%20', 'g')
	execute ':normal! i' . prefix . substitute(winpath, '\', '/', 'g')
endfunction

" More fzf mapping
nnoremap <C-p> :Files<cr>
nnoremap <C-o> :Buffer<cr>
" fuzzy search for lines in file
nnoremap <leader>b :BLines<cr>
" fuzzy search for word in buffer
nnoremap <leader>r :Rg<cr>

" map relative path completion to <c-f> in edit mode
" inoremap <c-f> <c-o>:call fzf#run({'source': 'git ls-files *.jpg *.jpeg *.png *.pdf *.svg *.html *.PNG', 'sink': function('MyRelPath')}) <CR> 
" this method is a bit slow (external call to powershell), but it works
" consistently (i.e. across different git folders)
" inoremap <c-f> <c-o>:call fzf#run({'source': 'powershell -command "git ls-files $(git rev-parse --show-toplevel)"', 'sink': function('MyRelPath')}) <CR> 
" for current method to work need to run "git config --global
" alias.ls-files-root "! git ls-files" in terminal"
inoremap <c-f> <c-o>:call fzf#run({'source': 'git ls-files-root', 'sink': function('MyRelPath')}) <CR>

" map scrolling
nnoremap <Space> <PageDown> 
nnoremap <S-Space> 

" set tabs to display smaller
set tabstop=2
set softtabstop=2
set shiftwidth=2

" turn on line numbers
set number

" set colors in crystalline
function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %2.40f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
	return crystalline#bufferline(3, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_enable_sep = 0
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'default'

set showtabline=2
set guioptions-=e
set laststatus=2

" code highlighting for other languages inside markdown
let g:markdown_fenced_languages = ['html', 'css', 'python', 'bash=sh', 'tex']

" replace all span titles
nmap <C-t> :%s!<span>\(.*\)</span>!----\r## \1!g<CR>

" shortcuts for aligning tables with tabular
if exists(":Tabularize")
	nnoremap <Leader>a :Tabularize /<bar><cr>
endif

" shortcut to edit init.vim
nnoremap <C-i> :tabedit ~/AppData/Local/nvim/init.vim <CR>

" mappings for sneak to jump around page more easily
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" general use shortcuts
let mapleader=","
let maplocalleader=","
" save
nnoremap <leader>w :w<cr>
nnoremap <leader>q :wq<cr>
" replace word under cursor
nnoremap <leader>f :%s/\<<c-r><c-w>\>//g<left><left>
" move lines up or down
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==

" open todo list in right split
nnoremap <leader>t :execute 'bo vs ' . g:todofile <cr>

" turn off highlighting after search
nnoremap <leader>n :noh<cr>

" git mapping 
nnoremap <leader>s :G <cr>
nnoremap <leader>z :Gpush <CR>

" cd to current file
nnoremap <leader>c :cd %:p:h<cr>

" open current file in nerd tree
map <leader>r :NERDTreeFind<cr>

" spelling
setlocal spell
set spelllang=en_us
" better solution is to use ftplugin https://vi.stackexchange.com/questions/6950/how-to-enable-spell-check-for-certain-file-types
autocmd FileType latex,tex,md,markdown setlocal spell
" set rtp+=C:\ProgramData\chocolatey\bin\fzf.exe

