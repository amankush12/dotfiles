
" I edited the source code of friendly-snip ~/.local/share/nvim/site/pack/packer/start/friendly-snippets/package.json
" to make it work just search for html and css and uncomment the whole thing 

source ~/.config/nvim/config.lua
source ~/.config/nvim/abbr.vim
source ~/.config/nvim/emmetConf.vim
autocmd Filetype python nnoremap <buffer> <F6> :w<CR>:vert ter python3 "%"<CR>
autocmd Filetype javascript nnoremap <buffer> <F6> :w<CR>:vert ter node "%"<CR>

" Es lint commad fixall
autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

"open and create a new file under the cursor 
:noremap <leader>gf :tabe <cfile><cr>

" Remove newbie crutches in Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" Remove s map for sandwitch
 nmap s <Nop>
 xmap s <Nop>

" get a extra white character 
 set ve+=onemore

" Flymode on in autopairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" Tss server start for javascript
lua << EOF 
require'lspconfig'.tsserver.setup{}
EOF 

" Vim Wiki to mark down 


let g:vimwiki_list = [{'path': '~/vimwiki/',
 \ 'syntax': 'markdown', 'ext': '.md'}]


"UltiSnip Settings ---------------------------------------------------------------------- 
 
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" UltiSnip directory 
"let g:UltiSnipsSnippetDirectories = ["~/.local/share/nvim/site/pack/packer/start/ultisnips/"]
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

"vim calender ----------------------------------------------------------------------
"let g:calendar_options = 'nornu'
" It's a toggle calender fucntion 
 function! ToggleCalendar()
  execute ":CalendarH"
  if exists("g:calendar_open")
    if g:calendar_open == 1
     execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
nnoremap <silent> <leader>0 :call ToggleCalendar()<CR>

