" Kyle Merfeld's vimrc
"
" sets <leader> to space 
let g:mapleader = "\<Space>"


"""""""""""""""""""
"   Plug plugins  "
"""""""""""""""""""
call plug#begin('~/.vim/plugged')

                            
"Looks
""""""
Plug 'dodie/vim-disapprove-deep-indentation'    "ಠ_ಠ
Plug 'nathanaelkane/vim-indent-guides'          "shows indents more
Plug 'airblade/vim-gitgutter'                   "shows changed lines
Plug 'itchyny/lightline.vim'                    "Statusbar
Plug 'luochen1990/rainbow'                      "Shows matching paren
Plug 'morhetz/gruvbox'                          "ColorScheme of choice


"More Functionallity
""""""""""""""""""""
" use multiple 'v' to select with visual mode
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'sebastianmarkow/deoplete-rust'        " Rust autocomplete
Plug 'ludovicchabant/vim-gutentags'         " ctags
Plug 'MattesGroeger/vim-bookmarks'          " <leader>m to bookmark
Plug 'alcesleo/vim-uppercase-sql'           " Auto type sql uppercase
Plug 'terryma/vim-expand-region'            " lazily select region 
Plug 'ivalkeen/vim-simpledb'                " Allows you to connect to db 
Plug 'racer-rust/vim-racer'                 " work with rust
Plug 'chrisbra/Recover.vim'                 " Makes swap files better
Plug 'sheerun/vim-polyglot'                 " Acts like a language pack
Plug 'rust-lang/rust.vim'                   " work with rust
Plug 'kmerfeld/term_test'                   " run tests
Plug 'ervandew/supertab'                    " tab but better
Plug 'junegunn/goyo.vim'                    " Distraction free writing
Plug 'majutsushi/tagbar'                    " <leader>b to see ctags
Plug 'junegunn/fzf.vim'                     " search files
Plug 'vimwiki/vimwiki'                      " Personal wiki 
Plug 'kien/ctrlp.vim'                       " Should move to fzf, but im lazy
Plug 'exu/pgsql.vim'                        " Postgresql syntax
Plug 'w0rp/ale'                             " Syntax


"Nvim
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/denite.nvim'





call plug#end()

"Under Consideration
""""""""""""""""""""
"   These plugins are in a trial period of whether or not to keep


"This one is intentionally last
""""""""""""""""""""
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1


"Plugin Config
""""""""""""""

"Looks config
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:rainbow_active = 1
let g:lightline = {
            \ 'component_function': {
            \   'filetype': 'MyFiletype',
            \   'fileformat': 'MyFileformat',
            \ }
            \ }


vmap v <Plug>(expand_region_expand)
let g:SuperTabDefaultCompletionType = '<c-n>'
" Rust autoformat
let g:rustfmt_autosave = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary='/home/kyle/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/kyle/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" rust-racer
let g:racer_cmd ='~/.cargo/bin/racer'
let $RUST_SRC_PATH='/home/kyle/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src' 
let g:racer_experimental_completer = 1


"Set default sql syntax
let g:sql_type_default = 'pgsql'

"rls
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


"Distraction free editing
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
endfunction

command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>


"tmux_test
let g:rtmux = {'rust': 'cargo run',
            \ 'vim': 'pwd',
            \} 
let g:ttmux = {'rust': 'cargo test',
            \ 'vim': 'pwd',
            \}
let g:ctmux = {'rust': 'cargo check',
            \ 'vim': 'pwd',
            \}

"Auto delete unedited swap files
let g:RecoverPlugin_Delete_Unmodified_Swapfile = 1


" will place a timestamp with f3
" https://box.matto.nl/systemnotesvimwiki.html
let g:vimwiki_hl_headers = 1
map <F3> :r! date +"\%Y-\%m-\%d \%H:\%M:\%S"<ESC>0j    
let g:vimwiki_folding='expr'

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
    let l:link = a:link
    if l:link =~# '^vfile:'
        let l:link = l:link[1:]
    else
        return 0
    endif
    let l:link_infos = vimwiki#base#resolve_link(l:link)
    if l:link_infos.filename ==# ''
        echomsg 'Vimwiki Error: Unable to resolve link!'
        return 0
    else
        exe 'tabnew ' . fnameescape(l:link_infos.filename)
        return 1
    endif
endfunction


autocmd FileType vimwiki set spell spelllang=en_gb

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
let g:gutentags_cache_dir = '~/.tags'

nnoremap <silent> <Leader>b :TagbarToggle<CR>

"ale 
let g:ale_enabled = 1

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




"""""""""""""""""""
"    Settings	  "
"""""""""""""""""""
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" give me another option to go to the beginning and end of a line
map <leader>a ^
map <leader>; $

" Tab stuff
" For regular expressions turn magic on
set magic
set smarttab
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set scrolloff=2
set list lcs=trail:·,tab:»·
set smartindent
set spell spelllang=en_us

" :w!! 
" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null

" make swap files less anoying
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo

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
if !exists('g:syntax_on')
    syntax enable
endif

" Turns on autoComplete
filetype plugin on

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

set timeoutlen=500

" Shows partial commands
set showcmd 				

" Return to last edit position when opening files
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif"

" Set 81st column to be highlighted
highlight ColorColumn ctermbg=magenta ctermfg=black
let &colorcolumn=join(range(81,335), ',')

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Smart copy and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p

" some nice bindings
map <leader>v :vnew<cr>
map <leader>V :new<cr>
map <leader>x :bd<cr>


" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" Set the current line to be highlighted black
" Black because it doesn't interfere with my color scheme,
" and I have this so that it is easier to see where I am
set cursorline
highlight  CursorLine ctermbg=black

" Changes terminal cursor to red. Makes sure I know where I am
highlight TermCursor ctermfg=red guifg=red

" Set vim to 256 color mode
set t_Co=256
" set colorscheme
"
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
    noremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l
    inoremap <C-h> <Esc><C-w>h
    inoremap <C-j> <Esc><C-w>j
    inoremap <C-k> <Esc><C-w>k
    inoremap <C-l> <Esc><C-w>l
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

"Swap a and i because Im stubborn
nnoremap a i
nnoremap i a
