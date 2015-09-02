filetype plugin indent on
set encoding=utf-8
execute pathogen#infect()
inoremap jk <ESC>
set number		"this just makes number lines apear

"this is for tabs
"Vertical Split : Ctrl+w + v
"horizontal split: Ctrl+w + s
"Close current windows: Ctrl+w + q
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"za to open or close fold
set foldmethod=indent
set foldlevel=99


"syntastic

set statusline+=%#warnings#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open =1
let g:syntastic_check_on_wq = 1

"python autocomplete
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview

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

filetype plugin on
set omnifunc=syntaxcomplete#Complete

"CoVim settings. This will complain if you dont have CoVim working.
let CoVim_default_name = "kmerfeld1"
let CoVim_default_port = "8555"

"auto sources vimrc file if file is named .vimrc
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Insert into your .vimrc after quick-scope is loaded.
" Obviously depends on <https://github.com/unblevable/quick-scope> being installed.

" Thanks to @VanLaser for cleaning the code up and expanding capabilities to include e.g. `df`

let g:qs_enable = 0
let g:qs_enable_char_list = [ 'f', 'F', 't', 'T' ]

function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif
    let letter = nr2char(getchar())
    if needs_disabling
        QuickScopeToggle
    endif
    return a:movement . letter
endfunction

for i in g:qs_enable_char_list
	execute 'noremap <expr> <silent>' . i . " Quick_scope_selective('". i . "')"
endfor


" Only show quick-scope highlights after f/F/t/T is pressed
function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif

    let letter = nr2char(getchar())

    if needs_disabling
        QuickScopeToggle
    endif

    return a:movement . letter
endfunction

let g:qs_enable = 0

for i in  [ 'f', 'F', 't', 'T' ]
    execute 'noremap <expr> <silent>' . i . " Quick_scope_selective('". i . "')"
endfor



