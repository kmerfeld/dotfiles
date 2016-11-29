map <leader>t :tabnew<cr>
map <leader>v :vnew<cr>
map <leader>h :new<cr>
map <leader>x :bd<cr>
"Note: this one only will work with neovim
map <leader>g :terminal<cr> 


"""""""""""""""""""""""""
"	NeoVim		"
"""""""""""""""""""""""""
"https://medium.com/@garoth/neovim-terminal-usecases-tricks-8961e5ac19b9#.ph8fxpnhk
" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" Terminal settings
if has('nvim')
	tnoremap <ESC> <C-\><C-n>

	"this is a hack to fix <C-h> in neovim
	"if has('nvim')
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
	" Hack to get C-h working in neovim
	nmap <BS> <C-W>h
	tnoremap <Esc> <C-\><C-n>


	" Window navigation function
	" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
	func! s:mapMoveToWindowInDirection(direction)
		func! s:maybeInsertMode(direction)
			stopinsert
			execute "wincmd" a:direction

			if &buftype == 'terminal'
				startinsert!
			endif
		endfunc

		execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
					\ "<C-\\><C-n>"
					\ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
		execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
					\ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
	endfunc

	for dir in ["h", "j", "l", "k"]
		call s:mapMoveToWindowInDirection(dir)
	endfor
endif

