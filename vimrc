filetype plugin indent on
set encoding=utf-8

"setup for pathogen plugin manager
execute pathogen#infect()

"bind 'jk' to escape
inoremap jk <ESC>

"this makes number lines apear
set number
set foldmethod=indent
set foldlevel=99
set t_Co=256

"set syntax highlighting
syntax enable

"set colorscheme stuff
set background=dark
colorscheme gruvbox

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
set t_vb=
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
map <C-n> :NERDTreeToggle<CR>
"vim-expand=region settings
"this maps it so i can use multiple 'v's to add to visuall mode
vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)

filetype plugin on
set omnifunc=syntaxcomplete#Complete


" invoke with '-'
nmap  -  <Plug>(choosewin)
" if you want to use overlay feature
let g:choosewin_overlay_enable = 1

		  
"""""""""""""""""""
"      Tabs	  "
"""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j a
map <C-k> <C-W>k a 
map <C-h> <C-W>h a
map <C-l> <C-W>l a

 " Useful mappings for managing tabs
 map <leader>v :vnew<cr>
 map <leader>h :new<cr>
 map <leader>x :bd<cr>
 map <leader>t :terminal<cr>



"""""""""""""""""""""""""
"	NeoVim		"
"""""""""""""""""""""""""

"https://medium.com/@garoth/neovim-terminal-usecases-tricks-8961e5ac19b9#.ph8fxpnhk
" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" Terminal settings
tnoremap <ESC> <C-\><C-n>

"this is a hack to fix <C-h> in neovim
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  " Hack to get C-h working in neovim
  nmap <BS> <C-W>h
  tnoremap <Esc> <C-\><C-n>
endif


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
