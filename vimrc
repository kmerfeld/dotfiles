"Kyle Merfeld's vimrc

"sets <leader> to space 
let mapleader = "\<Space>"


"""""""""""""""""""
"   Plug plugins  "
"""""""""""""""""""

" Here are the bulk of my pluggins
call plug#begin('~/.vim/plugged')
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/csv.vim'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'kablamo/vim-git-log'
Plug 'scrooloose/syntastic'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'vimwiki/vimwiki'
Plug 'kien/ctrlp.vim'
Plug 'ryanss/vim-hackernews'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-obsession'
Plug 'vim-latex/vim-latex'
Plug 'dodie/vim-disapprove-deep-indentation'
Plug 'ludovicchabant/vim-gutentags'


" The following block is for NeoVim plugins or ones that have dependencies 
" that i cannot assume every machine will have
if has ('nvim')
    Plug 'davidhalter/jedi-vim'
    Plug 'blindFS/vim-taskwarrior'
    "Plug 'tbabej/taskwiki'

    Plug 'zchee/deoplete-jedi'
    " This one updates plugins, keep it last
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
call plug#end()


"""""""""""""""""""
"  plugin config  "
"""""""""""""""""""

" vimwiki
let g:vimwiki_folding='expr'

let wiki = {}
let wiki.path ='$HOME/Nextcloud/wiki' 
let wiki.template_path = '$HOME/dotfiles/vimwiki/templates/'
let wiki.template_default = 'default'
let wiki.template_ext = '.html'

let work_wiki = {}
let work_wiki.path ='$HOME/Nextcloud/work_wiki' 
let work_wiki.template_path = '$HOME/dotfiles/vimwiki/templates/'
let work_wiki.template_default = 'default'
let work_wiki.template_ext = '.html'

let school_wiki = {}
let school_wiki.path ='$HOME/Nextcloud/school_wiki' 
let school_wiki.template_path = '$HOME/dotfiles/vimwiki/templates/'
let school_wiki.template_default = 'default'
let school_wiki.template_ext = '.html'

let capstone_wiki = {}
let capstone_wiki.path ='$HOME/Nextcloud/capstone_wiki' 
let capstone_wiki.template_path = '$HOME/dotfiles/vimwiki/templates/'
let capstone_wiki.template_default = 'default'
let capstone_wiki.template_ext = '.html'
let g:vimwiki_list = [wiki, work_wiki, school_wiki, capstone_wiki]

let g:vimwiki_hl_headers = 1
let g:vimwiki_auto_tags = 1
let g:vimwiki_auto_toc = 1
let g:vimwiki_auto_export = 0
let g:vimwiki_hl_cb_checked = 1

" will place a timestamp with f3
" https://box.matto.nl/systemnotesvimwiki.html
map <F3> :r! date +"\%Y-\%m-\%d \%H:\%M:\%S"<ESC>0j    

" syntastic
set statusline=%#warningmsg#
set statusline=%{SyntasticStatuslineFlag()}
set statusline=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
let g:systastic_rust_checkers = 1

" CSV
" highlight selected column
let g:csv_highlight_column = 'y'
hi CSVColumnEven term=bold ctermbg=4 guibg=DarkBlue
hi CSVColumnOdd  term=bold ctermbg=5 guibg=DarkMagenta



" Rust autoformat
let g:rustfmt_autosave = 1

" rust-racer
set hidden
let g:racer_cmd ="~/dotiles/vim/plugged/vim-racer"
let $RUST_SRC_PATH="/usr/share/doc/rust/html/src"



" easymotion
let g:EasyMotion_leader_key = '<Leader>' 
map <Leader> <Plug>(easymotion-prefix)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" this maps it so i can use multiple 'v's to add to visuall mode
vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)


" set colorscheme
set background=dark
colorscheme gruvbox


" This stuff is disabled because it is too slow on my chromebook
if has ('nvim')
    " deoplete.
    let g:deoplete#enable_at_startup = 1
    autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
    autocmd CompleteDone * pclose " To close preview window of deoplete automagically
endif


" utilisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"



"""""""""""""""""""
"    Settings	  "
"""""""""""""""""""

" give me another option to go to the beginning and end of a line
nmap <leader>a ^
nmap <leader>; $

" Tab stuff
" For regular expressions turn magic on
set magic
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set scrolloff=2
set list lcs=trail:·,tab:»·
set si " Smart indent

" toggle tmux bar when entering vim
autocmd VimEnter,VimLeave * silent !tmux set status

" tab bar along top
let g:airline#extensions#tabline#enabled = 1 


" :w!! 
" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null

" make swap files less anoying
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

filetype plugin indent on
set encoding=utf-8

" bind 'jk' to escape
inoremap jk <ESC>

" this makes number lines apear
set number

" allows folding based on indent
set foldmethod=indent
set foldlevel=99

" Set vim to 256 color mode
set t_Co=256

" set syntax highlighting
syntax enable

" Turns on autoComplete
set omnifunc=syntaxcomplete#Complete

" Line wrap type stuff
set wrap
set linebreak
set nolist  " list disables linebreak

" Set show matching parenthesis
set showmatch                       	

" Ignore case when searching
set ignorecase                      	

" Reload the file when it has been chaged outside of vim
set autoread                        	

" Highlight search results
set hlsearch 			   	

" No annoying sound on errors
set noerrorbells 			
set novisualbell

set tm=500

" show when leader is pressed
set showcmd 				

" Return to last edit position when opening files
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif"

" Set 81st column to be highlighted
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Smart copy and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


" Tabs
" Smart way to move between windows
map <C-j> <C-W>j a
map <C-k> <C-W>k a 
map <C-h> <C-W>h a
map <C-l> <C-W>l a
map <leader>t :tabnew<cr>
map <leader>v :vnew<cr>
map <leader>h :new<cr>
map <leader>x :bd<cr>
"Note: this one only will work with neovim
map <leader>g :terminal<cr> 

" Set the current line to be highlighted black
" Black because it doesnt interfere with my colorscheme,
" and I have this so that it is easyer to see where I am
set cursorline
highlight  CursorLine ctermbg=black

"""""""""""""""""""""""""
"	     NeoVim		    "
"""""""""""""""""""""""""

if has('nvim')
    map <leader>v :vnew<cr>
    map <leader>h :new<cr>
    map <leader>x :bd<cr>
    map <leader>t :terminal<cr>
    tnoremap <Esc> <C-\><C-n>

endif

" https://medium.com/@garoth/neovim-terminal-usecases-tricks-8961e5ac19b9#.ph8fxpnhk
" Window split settings
highlight TermCursor ctermfg=red guifg=red
