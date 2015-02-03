filetype plugin indent on
set encoding=utf-8
" map : ; 		"this makes it so i dont need to use shift
 inoremap jk <ESC>       
 set number		"this just makes number lines apear

execute pathogen#infect()


set t_Co=256
set term=xterm-256color


syntax enable
set background=dark
colorscheme jellybeans



:set wrap
:set linebreak
:set nolist  " list disables linebreak

map <C-n> :NERDTreeToggle<CR>



"  this makes it easy to only code to 80 lines
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%80v', 100)
  

set showmatch                       " Set show matching parenthesis
set ignorecase                      " Ignore case when searching
set autoread                        " Reload the file when it has been chaged outside of vim


"vim-expand=region settings
"this maps it so i can use multiple 'v's to add to visuall mode

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
