function! coc#source#lsdyna#init() abort
	" options for current source
	return {
		\'shortcut': 'lsdyna',
		\'priority': 3,
		\'filetypes': ['lsdyna'],
	\}
endfunction

function! coc#source#lsdyna#complete(opt, cb) abort
	let items = [{
		\ "word": "keyword"
		\}, {
		\ "word": "parameter"
		\}]
	call a:cb(items)
endfunction
