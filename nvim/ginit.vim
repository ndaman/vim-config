"settings for fvim
if exists('g:fvim_loaded')
"	set guifont=peep\ Regular:h18
	nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
	nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
	nnoremap <A-CR> :FVimToggleFullScreen<CR>
	"use shift-insert to paste from system in insert mode
	imap <silent> <S-Insert> <C-R>+
"this is for nvim-qt
elseif exists('g:GuiLoaded')
	set guifont=consolas:h20
	GuiTabline 0
	GuiPopupmenu 0
	call GuiWindowMaximized(1)
	"use shift-insert to paste from system in insert mode
	imap <silent> <S-Insert> <C-R>+
endif
