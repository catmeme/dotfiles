" .vimrc
" Tyler Mulligan <z@interwebninja.com>
" Last Updated 10/13/2010                 

" Environment Basics
set nocompatible        " don't keep vi bugs
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
