filetype plugin indent on
set encoding=utf-8
execute pathogen#infect()
inoremap jk <ESC>       
set number		"this just makes number lines apear

set t_Co=256
set term=xterm-256color
syntax enable
set background=dark
colorscheme gruvbox
"some of the colorschemes i have are,
"gruvbox, vividchalk, colors-solorized
:set wrap
:set linebreak
:set nolist  " list disables linebreak

map <C-n> :NERDTreeToggle<CR>

set showmatch                       " Set show matching parenthesis
set ignorecase                      " Ignore case when searching
set autoread                        " Reload the file when it has been chaged outside of vim


"vim-expand=region settings
"this maps it so i can use multiple 'v's to add to visuall mode
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)



"CoVim settings. This will complain if you dont have CoVim working.
let CoVim_default_name = "kmerfeld1"
let CoVim_default_port = "8555"

"auto sources vimrc file if file is named .vimrc
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

"opens .vimrc with 
let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>
