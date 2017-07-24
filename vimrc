" Vimrc

filetype off " Automatically detect file types.
set nocompatible " no vi compatibility.

" Use Vundle to manage plugins.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source ~/.vim/vimrc.bundles
call vundle#end()

" Enable plugins
filetype plugin indent on

" Add recently accessed projects menu (project plugin)
set viminfo^=\!

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Netrw
let g:netrw_list_hide= '.*\.swp$'  " Ignore *.swp files

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Setting colorscheme
syntax enable
set background=dark
colorscheme solarized
syntax on

" Larger history storage
set history=1000

"Set column limit for syntax highlighting
set synmaxcol=128

set cf  " Enable error files & error jumping.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set title " Let vim change my tab/window title
set autoread
set modifiable

" Formatting
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr

" More powerful backspacing
set backspace=indent,eol,start

" Indentation
set autoindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

autocmd Syntax html,css,ruby,javascript,coffee,cpp,java set tabstop=2 shiftwidth=2

" JQuery syntax support
autocmd Syntax javascript set syntax=jquery

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modesc

" Optimize scrolling
set ttyfast
set ttyscroll=3
set lazyredraw

" copy and cut to OS clipboard
set clipboard=unnamedplus

" Highlights all matches during search
set hlsearch

" Ignore case matching
set ignorecase

" Hightlight empty spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

 " Automatically change the working directory to the current one
au BufEnter * silent! lcd %:p:h
"match ErrorMsg '\s\+$'

" For Split screen users: higlight the status line of the active window
set laststatus=2                " Always display the last status
hi StatusLine ctermfg=Cyan

" NerdTree
let g:NERDChristmasTree=1
let g:NERDTreeWinSize=40

" Key Mapping
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
map <C-n> :NERDTreeToggle<CR>
nnoremap <Space> :noh<CR>

" Keyboard Mapping
command W wa
command Q qa
command WQ xa
" command Q! qa!

" Vim Buffer
nnoremap <C-p> :b#<CR>
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" Define Custom FileTypes
au BufNewFile,BufRead *.gcl set filetype=gcl
au BufNewFile,BufRead *.proto set filetype=proto
au BufNewFile,BufRead *.pi set filetype=piccolo

" Highlight Line too long
au FileType java set colorcolumn=100
au FileType soy set colorcolumn=100
au FileType proto set colorcolumn=80

au FileType javascript set colorcolumn=80
au FileType gcl set colorcolumn=80
au FileType piccolo set colorcolumn=80
au FileType cpp set colorcolumn=80
