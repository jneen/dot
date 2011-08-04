" Vim syntax file
" Language:		eco
" Maintainer:		Jay Adkisson

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'eco'
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn include @coffeeTop syntax/coffee.vim

syn cluster ecoRegions contains=ecoBlock,ecoExpression,ecoComment

syn region ecoBlock      matchgroup=ecoDelimiter start=/<%/      end=/%>/ contains=@coffeeTop containedin=ALLBUT,@ecoRegions keepend
syn region ecoExpression matchgroup=ecoDelimiter start=/<%[=\-]/ end=/%>/ contains=@coffeeTop containedin=ALLBUT,@ecoRegions keepend
syn region ecoComment    matchgroup=ecoComment   start=/<%#/     end=/%>/ contains=@coffeeTodo,@Spell containedin=ALLBUT,@ecoRegions keepend

" eco features not in coffeescript proper
syn keyword ecoEnd end containedin=@ecoRegions
syn match ecoIndentColon /\s+\w+:/ containedin=@ecoRegions

" Define the default highlighting.

hi def link ecoDelimiter    Delimiter
hi def link ecoComment      Comment
hi def link ecoEnd          coffeeConditional
hi def link ecoIndentColon  None

let b:current_syntax = 'eco'

if main_syntax == 'eco'
  unlet main_syntax
endif

" vim: nowrap sw=2 sts=2 ts=8:
