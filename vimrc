" Kyle Merfeld's vimrc
" everything is indented 1 spot for folding's sake
"
" sets <leader> to space 
let mapleader = "\<Space>"

"""""""""""""""""""
"   Plug plugins  "
"""""""""""""""""""
" Here are the bulk of my pluggins
call plug#begin('~/.vim/plugged')
Plug 'dodie/vim-disapprove-deep-indentation' " Teaches me to avoid excessive intentation
Plug 'terryma/vim-expand-region'            " use multiple 'v' to select with visual mode
Plug 'morhetz/gruvbox'                      " ColorScheme of choice
Plug 'vim-airline/vim-airline'              " Nicer bar along the bottum
Plug 'chrisbra/csv.vim'                     " work with csv files
Plug 'easymotion/vim-easymotion'            " move through code with less thought
Plug 'honza/vim-snippets'                   " Sometimes press tab to write a code block
Plug 'rust-lang/rust.vim'                   " work with rust
Plug 'racer-rust/vim-racer'                 " work with rust
Plug 'kablamo/vim-git-log'                  " :GitLog to see git commits
"Plug 'scrooloose/syntastic'                 " Syntax highlighting
Plug 'ervandew/supertab'                    " Completion with tab
Plug 'SirVer/ultisnips'                     " more snippets
Plug 'vimwiki/vimwiki'                      " Personal wiki 
Plug 'kien/ctrlp.vim'                       " Navigate files
Plug 'ryanss/vim-hackernews'                " slack off and read some news
Plug 'nvie/vim-flake8'                      " Python formatting
Plug 'tpope/vim-obsession'                  " save layout?
Plug 'ludovicchabant/vim-gutentags'         " ctags
Plug 'majutsushi/tagbar'                    " <leader>b to see ctags
Plug 'vim-scripts/DrawIt'                   " drawing graphs 
Plug 'christoomey/vim-tmux-navigator'       " Work together with tmux
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/nvim-cm-racer'
Plug 'w0rp/ale'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tpope/vim-fugitive'
Plug 'sebastianmarkow/deoplete-rust'

" The following block is for NeoVim plugins or ones that have dependencies 
" that i cannot assume every machine will have
if has ('nvim')
    Plug 'davidhalter/jedi-vim'             " Python support
    Plug 'blindFS/vim-taskwarrior'          " Taskwarrior support
    Plug 'tbabej/taskwiki'
    Plug 'zchee/deoplete-jedi'              " Python support neovim
    Plug 'zchee/deoplete-clang'             " C deoplete
    " This one updates plugins, keep it last
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
endif
call plug#end()

"""""""""""""""""""
"  plugin config  "
"""""""""""""""""""
"latex-preview
let g:livepreview_previewer = 'okular'
autocmd Filetype tex setl updatetime=1

" ctags 
let g:tagbar_type_rust = {
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \'T:types,type definitions',
            \'f:functions,function definitions',
            \'g:enum,enumeration names',
            \'s:structure names',
            \'m:modules,module names',
            \'c:consts,static constants',
            \'t:traits,traits',
            \'i:impls,trait implementations',
            \]
            \}

"vim fugitive
"https://www.reddit.com/r/vim/comments/6kfyae/vimfugitive_workflow/
nmap <leader>g :Gstatus<cr>gg<C-n>


"vim bookmarks
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1

"ale 
let ale_enabled = 1

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

let game_wiki = {}
let game_wiki.path ='$HOME/Nextcloud/game_wiki' 
let game_wiki.template_path = '$HOME/dotfiles/vimwiki/templates/'
let game_wiki.template_default = 'default'
let game_wiki.template_ext = '.html'

let g:vimwiki_list = [wiki, work_wiki, game_wiki]
let g:vimwiki_hl_headers = 1
let g:vimwiki_auto_tags = 1
let g:vimwiki_auto_toc = 1
let g:vimwiki_auto_export = 0
let g:vimwiki_hl_cb_checked = 1

" tmux_navigator
let g:tmux_navigator_no_mappings = 1

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


" supertab
" flips order you go over
let g:SuperTabDefaultCompletionType = "<c-n>"

" ctags
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir = "~/.tags"
nnoremap <silent> <Leader>b :TagbarToggle<CR>


" Rust autoformat
let g:rustfmt_autosave = 1

" rust-racer
set hidden
let g:racer_cmd ="~/dotiles/vim/plugged/vim-racer"
let $RUST_SRC_PATH="/usr/share/doc/rust/html/src"
let g:racer_experimental_completer = 1
let g:deoplete#sources#rust#racer_binary='/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path="/home/kyle/.rust/rust/src"
"let g:deoplete#sources#rust#disable_keymap=1
let g:deoplete#sources#rust#documentation_max_height=20

nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
nmap <buffer> K  <plug>DeopleteRustShowDocumentation


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
" vmap <C-v> <Plug>(expand_region_shrink)


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

"""""""""""""""""""""""""""
"    navigating splits	  "
"""""""""""""""""""""""""""
" auto use insert mode when moving to a terminal split
au BufEnter * if &buftype == 'terminal' | :startinsert | endif


if has ('nvim')
    " let you leave terminal insert mode with escape
    tnoremap <Esc> <C-\><C-n>

    "bindings for moveing between splits. terminal mode or normal
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " http://stackoverflow.com/questions/9092982/mapping-c-j-to-something-in-vim
    " This make ctrl-j work 
    augroup vimrc
        au!
        au VimEnter * unmap <C-j>
        au VimEnter * noremap <C-j> <C-w>j
    augroup END
endif

" lets you use ctl+hjlk for navigation in tmux
nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" This next line is to make sure <C-H> works in tmux
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>       

set splitbelow
set splitright

"""""""""""""""""""
"    Settings	  "
"""""""""""""""""""
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
" autocmd VimEnter,VimLeave * silent !tmux set status

" tab bar along top
let g:airline#extensions#tabline#enabled = 0


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
set foldmethod=syntax
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
highlight ColorColumn ctermbg=magenta ctermfg=black
call matchadd('ColorColumn', '\%81v', 100)

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Smart copy and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" some nice bindings
map <leader>t :terminal<cr>
map <leader>v :vnew<cr>
map <leader>h :new<cr>
map <leader>x :bd<cr>

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Set the current line to be highlighted black
" Black because it doesnt interfere with my colorscheme,
" and I have this so that it is easyer to see where I am
set cursorline
highlight  CursorLine ctermbg=black


" Changes terminal cursor to red. makes sure I know where I am
highlight TermCursor ctermfg=red guifg=red
