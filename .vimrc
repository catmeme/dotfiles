" .vimrc
" Tyler Mulligan <z@interwebninja.com>
" Last Updated 03/01/2016

set nocompatible        " don't keep vi bugs
filetype off            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'kien/tabman.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'blueshirts/darcula'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Theme
syntax enable           " highlighting
"colorscheme railscasts  " railscasts theme
set term=xterm-256color " for compatibility with tmux
set t_Co=256            " 256 color support   
set background=dark     " assume dark background
color darcula

" airline settings
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'
let g:airline#extensions#tabline#enabled = 1

" Environment Basics
set shortmess+=I        " remove splash
set virtualedit=all     " free roaming cursor
set paste               " sane pasting
set mouse=iv            " auto mouse
set ruler               " show cursor position
set number              " line numbers
"set spell               " spell checker
set history=100         " history
set visualbell          " No beeps

" Tabs
"set autoindent          " in favor of smart
set smartindent         " go with the flow
set tabstop=4           " normal tabs
set smarttab            " smart tabs
set softtabstop=4       " normal tabs
set shiftwidth=4        " normal tabs
set expandtab           " tabs to spaces

" Better Editor
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set linebreak           " Break lines at word
set showbreak=+++       " Broken line prefix
set textwidth=100       " Line wrap # of cols
set cursorline          " highlight current line
set showmatch           " braces
set incsearch           " search as you type
set hlsearch
set wrap                " wrap text
set wildmenu            " show commands at the bottom
set wildmode=list:longest,full
set autoread            " reload file when written to externally

" Simplify splitting hotkeys
map <C-H> <C-W>h<C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
nmap <leader>nt :NERDTreeToggle<cr>

" Tab switching ctrl + left/right
map <C-Left> <Esc>:tabprev<CR>
map <C-Right> <Esc>:tabnext<CR>
"nnoremap <C-h> <Esc>:tabprev<CR>
"nnoremap <C-l> <Esc>:tabnext<CR>

" New Tab ctrl + t
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Splits
nnoremap ,w <C-w>
nnoremap ,, <C-w><C-w>
nnoremap ,v :split<enter>
nnoremap ,h :vsplit<enter>

" sudo saver
command W w !sudo tee % > /dev/null

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]
let g:SuperTabLongestHighlight = 1

" Omnomnomnom
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Tab widths per filetype
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
