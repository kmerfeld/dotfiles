filetype plugin indent on
set encoding=utf-8
execute pathogen#infect()
inoremap jk <ESC>
set number		"this just makes number lines apear
set foldmethod=indent
set foldlevel=99
set t_Co=256
set term=xterm-256color
syntax enable
set background=dark
colorscheme gruvbox
:set wrap
:set linebreak
:set nolist  " list disables linebreak
let mapleader = "\<Space>"
map <C-n> :NERDTreeToggle<CR>
set showmatch                       	" Set show matching parenthesis
set ignorecase                      	" Ignore case when searching
set autoread                        	" Reload the file when it has been chaged outside of vim
set hlsearch 			   	"Highlight search results
set noerrorbells 			"No annoying sound on errors
set novisualbell
set t_vb=
set tm=500
set showcmd 				"show when leader is pressed

"vim-expand=region settings

"this maps it so i can use multiple 'v's to add to visuall mode
vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)
"


filetype plugin on
set omnifunc=syntaxcomplete#Complete


" invoke with '-'
nmap  -  <Plug>(choosewin)
" if you want to use overlay feature
let g:choosewin_overlay_enable = 1



" Return to last edit position when opening files (You want this!)
" autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif"



" Smart way to move between windows
 map <C-j> <C-W>j
 map <C-k> <C-W>k
 map <C-h> <C-W>h
 map <C-l> <C-W>l

 " " Useful mappings for managing tabs
 map <leader>v :vnew<cr>
 map <leader>h :new<cr>
 map <leader>bd :bd
