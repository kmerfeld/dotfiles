inoremap jk <ESC>
filetype plugin indent on
syntax on
set encoding=utf-8

"here is some genral config stuff

 set number		"so i can see what line i am on


" THIS IS CTRLP
 set runtimepath^=~/.vim/bundle/ctrlp.vim

" Set no max file limit
 let g:ctrlp_max_files = 0
 " Search from current directory instead of project root
 let g:ctrlp_working_path_mode = 0

 " Ignore these directories
 set wildignore+=*/out/**
 set wildignore+=*/vendor/**

 " Search in certain directories a large project (hardcoded for now)
 cnoremap %proj <c-r>=expand('~/Projects/some-project')<cr>
 " ga = go api
 map <Leader>ga :CtrlP %proj/api/<cr>
 " gf = go frontend
 map <Leader>gf :CtrlP %proj/some/long/path/to/frontend/code/<cr>

noremap ; :
noremap : ;


"  this makes it easy to only code to 80 lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
  




"this is for nerd tree plugin
map <C-n> :NERDTreeToggle<CR> 	
"this opens nerdtree with control n	

"this next line closes nerd tree under specail conditions, honestly it was
"just on the github so i grabbed it
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


