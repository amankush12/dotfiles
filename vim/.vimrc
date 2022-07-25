"Set compatibility to Vim only
set nocompatible

" Show line numbers
set number

"Status bar
set laststatus=2

" Automatically wrap text that extends beyond the screen length
set wrap

"Encoding 
set encoding=utf-8

"Enable file detection
filetype plugin on

"Enable plugins and load plugin for the detected file type
filetype plugin on

"Load indent file for the detected file type.
filetype indent on

"Syntax highlighing on
syntax on

"Highlight cursor line underneath the cursor horizontally  
set cursorline

"Highlight cursor line underneath the cursor vertically.
set cursorcolumn

"Set shift width to 4 spaces 
set shiftwidth=4

"Set tab width to 4 columns.
set tabstop=4

"Set space characters instead of tabs.
set expandtab

"Do not save backup files 
set nobackup

"Do not let cursor scroll below or above N number of lines when scrolling
set scrolloff=10

"While searching through file incrementally highlight matching charcter 
set incsearch

"Ignore capital letters during search.
set ignorecase

"Override the ignorecase option if searching for capital letters.
set smartcase

"show partial command 
set showcmd

"Show the mode you are on the last line.
set showmode

"Show matching words during a search.
set hlsearch 

"Set the commands to save in history default number is 20.
set history=1000

"Enable auto completion menu after pressing TAB.
set wildmenu 

"Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

"Wildmenu will ignore files with these extension.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


"PLUGINS-----------------------------------------------------











" }}}


" MAPPINGS---------------------------------------------------- {{{


 

" Mapping goes here 








" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}

"STATUS LINE----------------------------------------------






"}}}









