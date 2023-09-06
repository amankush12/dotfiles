"zo to open a single fold under the cursor.
"zc to close the fold under the cursor.
"zR to open all folds.
"zM to close all folds.

source ~/.vim/abbr.vim

let g:my_session_dir = '~/.vim/session/'

" Set the backup directory to the specified path
" Two backslashes to create bacup dir for every file so it doesn't overwrite 
set backupdir=~/.vim/vim_backup

" Alt+s to save the current file
map <A-a> :w<CR

" VIM SETTINGS -----------------------------------------------------------------{{{

set showcmd
set nocompatible
filetype on
filetype indent on
filetype plugin on
syntax on
set relativenumber
set encoding=UTF-8
set smarttab
set smartindent
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set re=0
set nowrap
set noswapfile
set incsearch
set scrolloff=10
set hlsearch
set history=1000
set ignorecase
set smartcase
set t_Co=256                    " Set if term supports 256 colors.
set cursorline                  " Shows the horizontal line in the cursor


set backup
set backupcopy=yes
" Use .bak as the extension for backup files
set backupext=.bak

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Using iTerm2? Go-to preferences / profile / colors and disable the smart bar
" cursor color. Then pick a cursor and highlight color that matches your theme.
" That will ensure your cursor is always visible within insert mode.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
""let &t_SR = "\<esc>[3 q" " underline cursor for replace mode
let &t_SI = "\<esc>[5 q" " I beam cursor for insert mode
let &t_EI = "\<esc>[2 q" " block cursor for normal mode
" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" }}}

" PLUGINS ----------------------------------------------------------------{{{

call plug#begin('~/.vim/plugged')
	
  " completion tool
  Plug 'neoclide/coc.nvim'    
  " start screent 
  Plug 'mhinz/vim-startify'    
  " Snippets 
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' 
  Plug 'sheerun/vim-polyglot'
  Plug 'preservim/nerdtree'
  Plug 'jiangmiao/auto-pairs'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-eunuch'
  Plug 'mattn/emmet-vim'
  Plug 'dmerejkowsky/vim-ale'
  Plug 'unblevable/quick-scope'
  Plug 'ap/vim-css-color'
  Plug 'yangmillstheory/vim-snipe'
  Plug 'frazrepo/vim-rainbow'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'preservim/vim-markdown'
  Plug 'junegunn/vim-emoji'
  Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
  Plug 'vimwiki/vimwiki'
  Plug 'ekalinin/dockerfile.vim'
  Plug 'Fymyte/rasi.vim'
  Plug 'jremmen/vim-ripgrep'
  " Add spelling errors to the quickfix list (vim-ingo-library is a dependency).
  Plug 'inkarkat/vim-ingo-library' | Plug 'inkarkat/vim-SpellCheck'
  Plug 'mhinz/vim-signify'
  Plug 'andymass/vim-matchup'

" Themes -------------------------------- 
  Plug 'ayu-theme/ayu-vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'sainnhe/edge'
  Plug 'rakr/vim-one'
  Plug 'mkarmona/materialbox'
  Plug 'romainl/Apprentice'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'morhetz/gruvbox'
  Plug 'cocopon/iceberg.vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'jacoborus/tender.vim'
  Plug 'sainnhe/everforest'
  Plug 'gosukiwi/vim-atom-dark'
  Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
  Plug 'arzg/vim-colors-xcode'
  Plug 'drewtempelmeyer/palenight.vim'

" Not using these plugins -------------------------------- 
  "Plug 'ycm-core/YouCompleteMe'
  "Plug 'prabirshrestha/vim-lsp'
  "Plug 'mattn/vim-lsp-settings'
  "Plug 'prabirshrestha/asyncomplete.vim'
  "Plug 'prabirshrestha/asyncomplete-lsp.vim'
  "Plug 'github/copilot.vim'

call plug#end()

" }}}

" MAPPINGS ---------------------------------------------------------------{{{

" Leader keys  
let mapleader = "\<Space>" 
let maplocalleader = "," 

" easy jj to escape
inoremap jj <esc>

" Turn off the highlights
nnoremap <silent><expr> <Leader>/ (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

"''''''''''''''''''''''''''''''
" file key bindings          
"''''''''''''''''''''''''''''''
" Filse saving
nmap <leader>fs :w!<cr>
" source file shortcut
nnoremap <Leader>fo :source %<CR>
" open vim config
nnoremap <Leader>fv :tabe ~/.vimrc<CR>
"file write 
nnoremap <Leader>fw :w<CR>
" quit without saving shortcut
nnoremap <Leader>qq :q!<CR>
" write and quit
nnoremap <Leader>wq :wq<CR>

" Define a mapping to navigate to a specific file
nnoremap <Leader>fg :e <C-R>=expand("<cfile>")<CR><CR>

" my abbrivetion file 
map <leader>fa :tabe ~/.vim/abbr.vim<cr>
autocmd! bufwritepost ~/.vim/abbr.vim source ~/.vim/abbr.vim

"Open previous file 
map <leader>pf :e#<cr> 

" Toggle between line numbers and relative line numbers
nnoremap <Leader>ln :set invnumber!<CR>:set relativenumber!<CR>

" split automatically if window doesn't exist
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we haven't moved
    if (match(a:key,'[jk]')+1) "we want to go up/down
      wincmd s
    elseif (match(a:key,'[hl]')+1) "we want to go left/right
      wincmd v
    endif
    exec "wincmd ".a:key
  endif
endfunction

"remap our split keys
map <C-h> :call WinMove('h')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>
map <C-j> :call WinMove('j')<cr>

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-h> <c-w>h
"nnoremap <c-l> <c-w>l

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Move current line down with Alt + j and up with Alt + k
nnoremap <LocalLeader>k :m .-2<CR>==
nnoremap <LocalLeader>j :m .+1<CR>==

" Set the local leader to comma
let maplocalleader = ","

function! CustomFindReplace()
  " Prompt the user for the word to find
  let word_to_find = input("Enter word to find: ")

  " Prompt the user for the word to replace with
  let word_to_replace = input("Enter word to replace with: ")

  " Prompt the user for options
  let options = input("Enter options (e.g., g for global, c for confirmation): ")

  " Construct the search and replace command
  let command = ':s/' . word_to_find . '/' . word_to_replace . '/' . options

  " Execute the command
  execute command
endfunction

" Bind the function to a key mapping (e.g., F3)
nnoremap <Leader>F :call CustomFindReplace()<CR>


"Tabs ----------------------------------------------------------
" Quickly switch between tabs
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>to :tabonly<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>tm :tabmove

" Move between tabs
nnoremap <Leader>th :tabprev<CR>
nnoremap <Leader>tl :tabnext<CR>

"Registers ----------------------------------------------------------

"Paste from clipboard to vim 
nnoremap <Leader>ps "+p

" Mapping to paste from default register
nnoremap <Leader>p :put<CR>

" Mapping to paste from the yank (copy) register
nnoremap <Leader>py :put *<CR>

" Mapping to paste from register 'a'
nnoremap <Leader>pa :put a<CR>

" Mapping to paste from register 'b'
nnoremap <Leader>pb :put b<CR>

"Buffers ----------------------------------------------------------
"
" Switch to the next buffer
nnoremap <Leader>bl :bnext<CR>

" Switch to the previous buffer
nnoremap <Leader>bh :bprev<CR>

" Delete current buffer (close file)
nnoremap <Leader>bk :bd<CR>

" Save all open buffers
nnoremap <Leader>bs :wa<CR>

" Create a new empty buffer
nnoremap <Leader>bn :enew<CR>

" Open a buffer by name
" Use FZF to select a buffer interactively
nnoremap <Leader>bo :Buffers<CR>
command! -bang -nargs=? Buffers call fzf#vim#buffers(<q-args>, <bang>0)


"Terminal ----------------------------------------------------------

" terminal in split window
map <c-w>t :term ++close<cr>
tmap <c-w>t <c-w>:term ++close<cr>

" terminal in new tab
map <c-w>tt :tab term ++close<cr>
tmap <c-w>tt <c-w>:tab term ++close<cr>

" vertical terminal in new tab
map <c-w>tv :tab term ++close<cr>
tmap <c-w>tv <c-w>:tab term ++close<cr>

" display register if you want to paste something 
map <>" <c-w>:dis<cr>
tmap <c-w>td <c-w>:dis<cr>

"Session -----------------------------------------------------------

function! SaveSession()
    let session_name = input('Enter session name: ')

    if session_name != ''
        let session_file = g:my_session_dir . session_name . '.vim'
        execute 'mksession! ' . session_file
        echo 'Session saved as ' . session_file
    else
        echo 'Session name cannot be empty'
    endif
endfunction

" Create a mapping to call the custom function
nnoremap <LocalLeader>sn :call SaveSession()<CR>

" Save the current session
nnoremap <LocalLeader>sm :mksession! ~/.vim/session/session.vim<CR>

" Load a session
" nnoremap <LocalLeader>sl :source <C-R>=expand("~/.vim/session/")<CR><Tab>

" List saved session files
" nnoremap <LocalLeader>sls :!ls ~/.vim/sessions<CR>

" Load the last session automatically on startup
" autocmd VimEnter * if argc() == 0 && filereadable(expand("~/.vim/last_session.vim")) | source ~/.vim/last_session.vim | endif

" Choose session 
function! ChooseSession()
let session_file = fzf#run({
      \ 'source': 'find ' . g:my_session_dir . ' -type f -name "*.vim"',
      \ 'sink': 'source',
      \ })
endfunction
nnoremap <LocalLeader>ss :call ChooseSession()<CR>

" }}}

" PLUGIN MAPPING -----------------------------------------------------{{{

" vimwiki

" Set colorscheme for vimwiki  
augroup VimWikiColor  
    au!  
    autocmd FileType vimwiki colorscheme edge 
augroup END  
augroup VimWikiAirlineTheme  
    au!  
    autocmd BufEnter *.wiki :AirlineTheme edge 
augroup END  

" highlights in underline and also changing color to cyan
hi VimwikiLink term=underline ctermfg=cyan guifg=cyan gui=underline

" Ripgrep
nnoremap <leader>r :Rg<space>


" startify 
" let g:startify_padding_left = 3

" auto pairs -------------------------------------
let g:AutoPairsFlyMode= 1

" lsp setup -----------------------------------------------------

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled (set the lsp shortcuts) when an lsp server
    " is registered for a buffer.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" --------------------------------------------------------





" --------------------------------------------------------
"Vim snipe key bindings -----------------------------------------------------





" --------------------------------------------------------

"VimWiki -----------------------------------------------------
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" --------------------------------------------------------


"Instant Markdown-----------------------------------------------------

let g:instant_markdown_autostart = 0         " Turns off auto preview
let g:instant_markdown_browser = "surf"      " Uses surf for preview
map <Leader>md :InstantMarkdownPreview<CR>   " Previews .md file
map <Leader>ms :InstantMarkdownStop<CR>      " Kills the preview

" --------------------------------------------------------


"Nerd tree-----------------------------------------------------
"Map the key to toggle NERDTree open and close.
nnoremap <leader>e :NERDTreeToggle<cr>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

" --------------------------------------------------------

"Easy mostion config -------------------------------------------------------- 

map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Leader>s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader>ss <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>sj <Plug>(easymotion-j)
map <Leader>sk <Plug>(easymotion-k)
"----------------------------------------------------------------------------

"Vim quick-scope -------------------------------------------------------- 

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg=#afff5f gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg=#ff0000 gui=underline ctermfg=1 cterm=underline

"Vim surround -------------------------------------------------------- 
" To stop using the predefined mapping
let g:surround_no_mappings = 1"
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap ys <Plug>Ysurround
nmap yS <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap SS <Plug>YSsurround
xmap S  <Plug>VSurround
xmap gS <Plug>VgSurround

" VIM multiple cursor-------------------------------------------------------
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Vim goyo -------------------------------------------------------

" Width
" let g:goyo_width='80%'

" Height
" let g:goyo_height='80%'

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set linebreak
  set spell spelllang=en_us 
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set nolinebreak
  set nospell 
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Themes -------------------------------------------------------

autocmd vimenter * colorscheme dracula 
let g:airline_theme='dracula'
set background=dark

" seoul theme settings --------------------------------
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
let g:seoul256_background = 233

" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
let g:seoul256_light_background = 253

" xcode theme settings --------------------------------
"
let g:signify_sign_add    = '┃'
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '•'

let g:signify_sign_show_count = 0 " Don’t show the number of deleted lines.

" Italic comments 
augroup vim-colors-xcode
    autocmd!
augroup END

autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic

" maping key for ColorSchemeToggle function 
nnoremap <Leader>ct :call ColorSchemeToggle()<CR>

" Define a function to change color scheme, Airline theme, and background color
function! ChangeColorSchemeAndOptions(selected)
  let color_scheme = split(a:selected)[0]
  let airline_theme = split(a:selected)[1]
  let background = split(a:selected)[2]

  " Set the color scheme
  execute 'colorscheme ' . color_scheme

  " Set the Airline theme
  let g:airline_theme = airline_theme

  " Set the background color
  if background == 'light'
    set background=light
  elseif background == 'dark'
    set background=dark
  endif

  " Display a message with the new settings
  echo 'Changed to color scheme: ' . color_scheme . ' Airline theme: ' . airline_theme . ' Background: ' . background
endfunction

" Define a command to trigger FZF color scheme selection
command! -bang -nargs=0 ColorSchemeToggle call ColorSchemeToggle()

" Create a function to call FZF for color scheme selection
function! ColorSchemeToggle()
  " Define a list of color schemes and their options
  let color_schemes = [
        \ ['onehalfdark', 'onehalfdark', 'dark'],
        \ ['onehalflight', 'onehalflight', 'light'],
        \ ['gruvbox', 'gruvbox', 'dark'],
        \ ['gruvbox', 'gruvbox', 'light'],
        \ ['PaperColor', 'papercolor', 'light'],
        \ ['PaperColor', 'tomorrow', 'dark'],
        \ ['ayu', 'ayu_dark', 'dark'],
        \ ['seoul256', 'seoul256', 'dark'],
        \ ['seoul256-light', 'seoul256', 'light'],
        \ ['edge', 'edge', 'light'],
        \ ['edge', 'edge', 'dark'],
        \ ['one', 'one', 'dark'],
        \ ['one', 'one', 'light'],
        \ ['materialbox', 'materialbox', 'light'],
        \ ['materialbox', 'materialbox', 'dark'],
        \ ['apprentice', 'apprentice', 'dark'],
        \ ['dracula', 'dracula', 'dark'],
        \ ['iceberg', 'iceberg', 'dark'],
        \ ['iceberg', 'iceberg', 'light'],
        \ ['everforest', 'everforest', 'light'],
        \ ['everforest', 'everforest', 'dark'],
        \ ['atom-dark-256', 'zenburn', 'dark'],
        \ ['tender', 'tender', 'dark'],
        \ ['xcodedarkhc', 'xcodedarkhc', 'dark'],
        \ ['xcodelight', 'xcodelight', 'light'],
        \ ['xcodewwdc', 'xcodewwdc', 'dark'],
        \ ['palenight', 'palenight', 'dark'],
        \ ]

  " Create a formatted list for FZF
  let color_options = []
  for scheme in color_schemes
    let color_option = printf('%s %s %s', scheme[0], scheme[1], scheme[2])
    call add(color_options, color_option)
  endfor

  " Use FZF to select a color scheme
  let selected = fzf#run({
        \ 'source': color_options,
        \ 'sink': function('ChangeColorSchemeAndOptions'),
        \ 'down': '60%',
        \ 'header': 'Select Color Scheme, Airline Theme, and Background:',
        \ 'options': '--reverse --preview "echo {1} | awk ''{print $1}'' | xargs echo -n | vim -c ''silent! colorscheme {}'' -"'})

  if empty(selected)
    echo 'No color scheme selected.'
  endif
endfunction

" Setting termguicolors 
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"}}}

" VIMSCRIPT ---------------------------------------------------------------{{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Coc settings  ----------------------------------------

let g:coc_config_home = '~/.vim/'
let g:coc_data_home = '~/.vim/'


inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<tab>"

function! s:ExpandSnippetOrClosePumOrReturnNewline()
    if pumvisible()
        if !empty(v:completed_item)
            let snippet = UltiSnips#ExpandSnippet()
            if g:ulti_expand_res > 0
                return snippet
            else
                return "\<C-y>"
            endif
        else
            return "\<C-y>\<CR>"
        endif
    else
        return "\<CR>"
    endif
endfunction
inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrClosePumOrReturnNewline()<CR>



let g:coc_global_extensions = ['coc-prettier']
"autocmd BufWritePre * silent! call CocAction('format')


"UltiSnips config -----------------------------------------------------

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"





" }}}

