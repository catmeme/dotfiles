" .vimrc
" Tyler Mulligan <z@interwebninja.com>
" Last Updated 10/13/2010                 

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

" Environment Basics
set term=xterm-256color " for compatibility with tmux
set shortmess+=I        " remove splash
set virtualedit=all     " free roaming cursor
set paste               " sane pasting
set mouse=iv            " auto mouse
set ruler               " show cursor position
set number              " line numbers
set spell               " spell checker
set history=100         " history
set background=dark     " assume dark background
set t_Co=256            " 256 color support   
set visualbell          " No beeps
syntax enable           " highlighting
colorscheme railscasts  " railscasts theme

" Tabs
set autoindent          " in favor of smart
set smartindent         " go with the flow
set tabstop=4           " normal tabs
set smarttab            " smart tabs
set softtabstop=4       " normal tabs
set shiftwidth=4        " normal tabs
set expandtab           " tabs to spaces

" Better Editor
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

" sudo saver
command W w !sudo tee % > /dev/null

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

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

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
