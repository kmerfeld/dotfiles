filetype plugin indent on
syntax on
set encoding=utf-8

 map : ; 		"this makes it so i dont need to use shift
 inoremap jk <ESC>      "this binds "jk" to escape 
 set number		"this just makes number lines apear


 "these next lines disable the arrow keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>





"  this makes it easy to only code to 80 lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%80v', 100)
  




