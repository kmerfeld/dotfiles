"Kyle Merfeld's vimrc

"""""""""""""""""""
"   Plug plugins  "
"""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 't9md/vim-choosewin'
Plug 'tpope/vim-sensible'
Plug 'Shougo/deoplete.nvim'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/csv.vim'
Plug 'easymotion/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'wting/rust.vim'
Plug 'racer-rust/vim-racer'
call plug#end()



"""""""""""""""""""
"    Settings	  "
"""""""""""""""""""
filetype plugin indent on

"set encoding=utf-8

"bind 'jk' to escape
inoremap jk <ESC>

"this makes number lines apear
set number
set foldmethod=indent
set foldlevel=99
set t_Co=256

"set syntax highlighting
syntax enable

"Line wrap type stuff
set wrap
set linebreak
set nolist  " list disables linebreak

"sets <leader> to space
let mapleader = "\<Space>"

set showmatch                       	" Set show matching parenthesis
set ignorecase                      	" Ignore case when searching
set autoread                        	" Reload the file when it has been chaged outside of vim
set hlsearch 			   	"Highlight search results
set noerrorbells 			"No annoying sound on errors
set novisualbell
set tm=500
set showcmd 				"show when leader is pressed

" Return to last edit position when opening files
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif"

"""""""""""""""""""
"     plugins     "
"""""""""""""""""""

"Rust autoformat
let g:rustfmt_autosave = 1

"rust-racer
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/kyle/.rust"



"easymotion
map <Leader> <Plug>(easymotion-prefix)

""nerdtree
map <C-n> :NERDTreeToggle<CR>
"vim-expand=region settings
"this maps it so i can use multiple 'v's to add to visuall mode
vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)

set omnifunc=syntaxcomplete#Complete

" invoke with '-'
nmap  -  <Plug>(choosewin)
" if you want to use overlay feature
let g:choosewin_overlay_enable = 1

"deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:deoplete#auto_completion_start_length = 1
set completeopt+=noinsert

"ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"set colorscheme stuff
set background=dark
colorscheme gruvbox

"""""""""""""""""""
"      Tabs	  "
"""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j a
map <C-k> <C-W>k a 
map <C-h> <C-W>h a
map <C-l> <C-W>l a

" Useful mappings for managing tabs
if has('nvim')
	map <leader>v :vnew<cr>
	map <leader>h :new<cr>
	map <leader>x :bd<cr>
	map <leader>t :terminal<cr>
endif


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

