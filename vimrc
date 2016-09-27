"Kyle Merfeld's vimrc

"""""""""""""""""""
"   Plug plugins  "
"""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/csv.vim'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'wting/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'kablamo/vim-git-log'
Plug 'scrooloose/syntastic'
Plug 'ervandew/supertab'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
"The following block is for NeoVim plugins or ones that have dependencies 
"that i cannot assume every machine will have
if has ('nvim')
	Plug 'davidhalter/jedi-vim'
	Plug 'zchee/deoplete-jedi'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'blindFS/vim-taskwarrior'
endif
call plug#end()



"""""""""""""""""""
"    Settings	  "
"""""""""""""""""""
filetype plugin indent on
set encoding=utf-8

"bind 'jk' to escape
inoremap jk <ESC>

"this makes number lines apear
set number

"allows folding based on indent
set foldmethod=indent
set foldlevel=99

"Set vim to 256 color mode
set t_Co=256

"set syntax highlighting
syntax enable

"Turns on autoComplete
set omnifunc=syntaxcomplete#Complete

"Line wrap type stuff
set wrap
set linebreak
set nolist  " list disables linebreak

"sets <leader> to space 
let mapleader = "\<Space>"

" Set show matching parenthesis
set showmatch                       	

" Ignore case when searching
set ignorecase                      	

" Reload the file when it has been chaged outside of vim
set autoread                        	

"Highlight search results
set hlsearch 			   	

"No annoying sound on errors
set noerrorbells 			
set novisualbell

set tm=500

"show when leader is pressed
set showcmd 				

" Return to last edit position when opening files
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif"

" Set 81st column to be highlighted
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"Tabs
" Smart way to move between windows
map <C-j> <C-W>j a
map <C-k> <C-W>k a 
map <C-h> <C-W>h a
map <C-l> <C-W>l a



"""""""""""""""""""
"     plugins     "
"""""""""""""""""""

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']

"CSV
"highlight selected column
let g:csv_highlight_column = 'y'
hi CSVColumnEven term=bold ctermbg=4 guibg=DarkBlue
hi CSVColumnOdd  term=bold ctermbg=5 guibg=DarkMagenta


"vim-notes
"sets note location
let g:notes_directories = ['~/ownCloud/homework/notes']
"disables tab indent
let g:notes_tab_indents = 0

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


"this maps it so i can use multiple 'v's to add to visuall mode
vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)


"set colorscheme
set background=dark
colorscheme gruvbox

if has ('nvim')
	"deoplete.
	let g:deoplete#enable_at_startup = 1
	autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
	autocmd CompleteDone * pclose " To close preview window of deoplete automagically
endif

"w3m.vim
let g:w3m#homepage = "https://duckduckgo.com"
let g:w3m#hit_a_hint_key = 'f'
let g:w3m#search_engine = "https://duckduckgo.com/?q="

"""""""""""""""""""""""""
"	NeoVim		"
"""""""""""""""""""""""""

if has('nvim')
	map <leader>v :vnew<cr>
	map <leader>h :new<cr>
	map <leader>x :bd<cr>
	map <leader>t :terminal<cr>
	tnoremap <Esc> <C-\><C-n>

endif


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

