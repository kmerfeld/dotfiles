" Kyle Merfeld's vimrc
" everything is indented 1 spot for folding's sake
"
" sets <leader> to space 
let mapleader = "\<Space>"


"""""""""""""""""""
"   Plug plugins  "
"""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

Plug 'https://github.com/dag/vim-fish'
Plug 'justinmk/vim-sneak'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'morhetz/gruvbox'                      " ColorScheme of choice
Plug 'dodie/vim-disapprove-deep-indentation' " I love this plugin, but it doesnt work well with my rust code
Plug 'jacoborus/tender.vim' "Vim airline theme
Plug 'airblade/vim-gitgutter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'


Plug 'wikitopian/hardmode'
"Hard Mode is a plugin which disables the arrow keys, the hjkl keys, the page up/down keys, and a handful of other keys which allow one to rely on character-wise navigation. The philosophy behind Hard Mode is that you'll never master Vim's advanced motion and search functionality if you can fall back on the anti-pattern of fumbling around your code with the arrow keys.
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode() " Start in hardmode
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>


" use multiple 'v' to select with visual mode
Plug 'terryma/vim-expand-region'   
vmap v <Plug>(expand_region_expand)

Plug 'itchyny/lightline.vim'
"lightline
let g:lightline = {
            \ 'component_function': {
            \   'filetype': 'MyFiletype',
            \   'fileformat': 'MyFileformat',
            \ }
            \ }


Plug 'scrooloose/nerdtree'
"nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


Plug 'luochen1990/rainbow'
"rainbow
let g:rainbow_active = 1


"Plug 'chrisbra/csv.vim'                     " work with csv files
" CSV
" highlight selected column
" let g:csv_highlight_column = 'y'
" hi CSVColumnEven term=bold ctermbg=4 guibg=DarkBlue
" hi CSVColumnOdd  term=bold ctermbg=5 guibg=DarkMagenta


Plug 'easymotion/vim-easymotion'            " move through code with less thought
" easymotion
let g:EasyMotion_leader_key = '<Leader>' 
map <Leader> <Plug>(easymotion-prefix)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


Plug 'honza/vim-snippets'                   " Sometimes press tab to write a code block


Plug 'SirVer/ultisnips'                     " more snippets
" utilisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


Plug 'rust-lang/rust.vim'                   " work with rust
" Rust autoformat
let g:rustfmt_autosave = 1

Plug 'Valloric/YouCompleteMe'
let g:ycm_rust_src_path = "/home/kyle/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/doc"

Plug 'racer-rust/vim-racer'                 " work with rust
" rust-racer
set hidden
let g:racer_cmd ="~/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/share/doc/rust/html/src" 
let g:racer_experimental_completer = 1

Plug 'kablamo/vim-git-log'                  " :GitLog to see git commits

Plug 'jreybert/vimagit'


Plug 'metakirby5/codi.vim'


Plug 'vimwiki/vimwiki'                      " Personal wiki 
" will place a timestamp with f3
" https://box.matto.nl/systemnotesvimwiki.html
let g:vimwiki_hl_headers = 1
map <F3> :r! date +"\%Y-\%m-\%d \%H:\%M:\%S"<ESC>0j    
" vimwiki
let g:vimwiki_folding='expr'
function! OpenSecretCalendar()
    call vimwiki#base#goto_index(2)
    execute ':Calendar'
endfunction
nnoremap <leader>c :call OpenSecretCalendar()<cr>

let g:vimwiki_folding='expr' "this allows the folding to work for markdown

let g:vimwiki_list = [{
            \ 'path': '~/Nextcloud/vimwiki',
            \ 'template_path': '~/vimwiki/templates/',
            \ 'nested_syntaxes': {
            \   'bash': 'sh'
            \  },
            \ 'template_default': 'default',
            \ 'path_html': '~/Nextcloud/vimwiki/site_html/',
            \ }]

function! VimwikiLinkHandler(link)
    " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
    "   1) [[vfile:~/Code/PythonProject/abc123.py]]
    "   2) [[vfile:./|Wiki Home]]
    let link = a:link
    if link =~# '^vfile:'
        let link = link[1:]
    else
        return 0
    endif
    let link_infos = vimwiki#base#resolve_link(link)
    if link_infos.filename == ''
        echomsg 'Vimwiki Error: Unable to resolve link!'
        return 0
    else
        exe 'tabnew ' . fnameescape(link_infos.filename)
        return 1
    endif
endfunction


autocmd FileType vimwiki set spell spelllang=en_gb

Plug 'kien/ctrlp.vim'                       " Navigate files


Plug 'nvie/vim-flake8'                      " Python formatting


Plug 'tpope/vim-obsession'                  " save layout?


Plug 'ludovicchabant/vim-gutentags'         " ctags
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

set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir = "~/.tags"


Plug 'majutsushi/tagbar'                    " <leader>b to see ctags
nnoremap <silent> <Leader>b :TagbarToggle<CR>


Plug 'christoomey/vim-tmux-navigator'       " Work together with tmux
let g:tmux_navigator_no_mappings = 1

" lets you use ctl+hjlk for navigation in tmux
nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" This next line is to make sure <C-H> works in tmux
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>       


Plug 'w0rp/ale'
"ale 
let ale_enabled = 1


Plug 'MattesGroeger/vim-bookmarks'
"vim bookmarks
highlight BookmarkSign ctermbg=red ctermfg=black
highlight BookmarkAnnotationSign ctermbg=red ctermfg=black
highlight BookmarkLine ctermbg=red ctermfg=black
highlight BookmarkAnnotationLine ctermbg=red ctermfg=black
let g:bookmark_sign ='⌬'
let g:bookmark_highlight_lines = 1
nmap <Leader>m <Plug>BookmarkToggle

let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1


"Plug 'sebastianmarkow/deoplete-rust'
" let g:deoplete#sources#rust#racer_binary='/usr/bin/racer'
" let g:deoplete#sources#rust#rust_source_path="/home/kyle/.rust/rust/src"
" "let g:deoplete#sources#rust#disable_keymap=1
" let g:deoplete#sources#rust#documentation_max_height=20
" nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
" nmap <buffer> K  <plug>DeopleteRustShowDocumentation


Plug 'cespare/vim-toml'


Plug 'timonv/vim-cargo'

" The following block is for NeoVim plugins
if has ('nvim')
    Plug 'davidhalter/jedi-vim'             " Python support
    "Plug 'zchee/deoplete-jedi'              " Python support neovim
    "Plug 'zchee/deoplete-clang'             " C deoplete
    " This one updates plugins, keep it last
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
    "if has ('nvim')
        " deoplete.
        "let g:deoplete#enable_at_startup = 1
        "autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
        "autocmd CompleteDone * pclose " To close preview window of deoplete automagically
    "endif
endif
call plug#end()


"""""""""""""""""""
"    Settings	  "
"""""""""""""""""""
"Format json
com! FormatJSON %!python -m json.tool
"vew .deck and .json as json files
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.deck set ft=javascript

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" give me another option to go to the beginning and end of a line
map <leader>a ^
map <leader>; $

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
set spell spelllang=en_us

" toggle tmux bar when entering vim
" autocmd VimEnter,VimLeave * silent !tmux set status

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
"set foldmethod=syntax
set foldlevel=99


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

" Set vim to 256 color mode
set t_Co=256
" set colorscheme
set background=dark
colorscheme gruvbox


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

set splitbelow
set splitright


