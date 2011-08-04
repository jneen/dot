set guifont=Monaco\ 11
colorscheme solarized
" no toolbar
set guioptions-=T

" no scrollbars, kthx
set guioptions+=LlRrb
set guioptions-=LlRrb

nmap <Leader>s :ConqueTerm /bin/bash<CR>

set clipboard=unnamed

let g:ConqueTerm_EscKey = '<F1>'
