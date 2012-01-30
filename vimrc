call pathogen#runtime_append_all_bundles()
syntax on

let g:ackprg="ack-grep -H --nocolor --nogroup --column"

autocmd BufNewFile,BufRead *.py  set shiftwidth=4 tabstop=4 softtabstop=4
" autocmd BufNewFile,BufRead *.tcl set shiftwidth=4 tabstop=4 softtabstop=4

set autoindent expandtab shiftwidth=2 tabstop=2 softtabstop=2

map <Tab> <C-w>

" up and down!
map <C-j> <C-d>
map <C-k> <C-u>

set t_Co=256

let g:CSApprox_verbose_level = 0
let g:CSApprox_hook_post = [ 'hi Normal  ctermbg=NONE ctermfg=NONE', 'hi NonText ctermbg=NONE ctermfg=NONE' ]

colorscheme thankful_eyes

set guioptions+=a
set guioptions+=c
nmap ; "+
vmap ; "+

let mapleader=" "
set wildmenu
set wildmode=list:longest

set mouse=a
set ttymouse=xterm

" I use F1 as my tmux prefix.
nmap <F1> <Nop>
imap <F1> <Nop>

fun! FnEruby(subtype)
  let b:eruby_subtype = a:subtype
  set syntax=eruby
endfun

command! -nargs=1 Eruby call FnEruby(<args>)

set wildignore+=.git,.hg,tmp,xapiandbs
set wildignore+=*.o,*.so
let g:CommandTMaxFiles = 20000

filetype on
filetype indent on
filetype plugin on

set showcmd

nmap <Leader>g :Gstatus<CR>
nmap <Leader>c :Gcommit -v<CR>
nmap <Leader>a :Gcommit -av<CR>
nmap <Leader>d :Gdiff<CR>
nmap <Leader>f :CommandTFlush<CR>
nmap <Leader>C :CoffeeCompile<CR>

nmap <C-t> :tabnew<CR>
nmap <C-Tab> :tabnext<CR>
nmap <C-q> :tabclose<CR>

set modeline
