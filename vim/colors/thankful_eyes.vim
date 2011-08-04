" Vim color file
" Maintainer: Jay Adkisson <j4yferd@gmail.com>

" All functions stolen from desert256 by Henry So, Jr.

set background=dark
hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name='thankful_eyes'

" functions {{{
" returns an approximate grey index for the given grey level
fun! <SID>grey_number(x)
    if &t_Co == 88
        if a:x < 23
            return 0
        elseif a:x < 69
            return 1
        elseif a:x < 103
            return 2
        elseif a:x < 127
            return 3
        elseif a:x < 150
            return 4
        elseif a:x < 173
            return 5
        elseif a:x < 196
            return 6
        elseif a:x < 219
            return 7
        elseif a:x < 243
            return 8
        else
            return 9
        endif
    else
        if a:x < 14
            return 0
        else
            let l:n = (a:x - 8) / 10
            let l:m = (a:x - 8) % 10
            if l:m < 5
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun

" returns the actual grey level represented by the grey index
fun! <SID>grey_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 46
        elseif a:n == 2
            return 92
        elseif a:n == 3
            return 115
        elseif a:n == 4
            return 139
        elseif a:n == 5
            return 162
        elseif a:n == 6
            return 185
        elseif a:n == 7
            return 208
        elseif a:n == 8
            return 231
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 8 + (a:n * 10)
        endif
    endif
endfun

" returns the palette index for the given grey index
fun! <SID>grey_color(n)
    if &t_Co == 88
        if a:n == 0
            return 16
        elseif a:n == 9
            return 79
        else
            return 79 + a:n
        endif
    else
        if a:n == 0
            return 16
        elseif a:n == 25
            return 231
        else
            return 231 + a:n
        endif
    endif
endfun

" returns an approximate color index for the given color level
fun! <SID>rgb_number(x)
    if &t_Co == 88
        if a:x < 69
            return 0
        elseif a:x < 172
            return 1
        elseif a:x < 230
            return 2
        else
            return 3
        endif
    else
        if a:x < 75
            return 0
        else
            let l:n = (a:x - 55) / 40
            let l:m = (a:x - 55) % 40
            if l:m < 20
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun

" returns the actual color level for the given color index
fun! <SID>rgb_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 139
        elseif a:n == 2
            return 205
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 55 + (a:n * 40)
        endif
    endif
endfun

" returns the palette index for the given R/G/B color indices
fun! <SID>rgb_color(x, y, z)
    if &t_Co == 88
        return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
        return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
endfun

" returns the palette index to approximate the given R/G/B color levels
fun! <SID>color(r, g, b)
    " get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " get the closest color
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
        " there are two possibilities
        let l:dgr = <SID>grey_level(l:gx) - a:r
        let l:dgg = <SID>grey_level(l:gy) - a:g
        let l:dgb = <SID>grey_level(l:gz) - a:b
        let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
        let l:dr = <SID>rgb_level(l:gx) - a:r
        let l:dg = <SID>rgb_level(l:gy) - a:g
        let l:db = <SID>rgb_level(l:gz) - a:b
        let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
        if l:dgrey < l:drgb
            " use the grey
            return <SID>grey_color(l:gx)
        else
            " use the color
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    else
        " only one possibility
        return <SID>rgb_color(l:x, l:y, l:z)
    endif
endfun

" returns the palette index to approximate the 'rrggbb' hex string
fun! <SID>rgb(rgb)
    let l:r = ('0x' . strpart(a:rgb, 0, 2)) + 0
    let l:g = ('0x' . strpart(a:rgb, 2, 2)) + 0
    let l:b = ('0x' . strpart(a:rgb, 4, 2)) + 0

    return <SID>color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group
fun! <SID>X(group, fg, bg, attr)
    if a:fg != ''
        exec 'hi ' . a:group . ' guifg=#' . a:fg . ' ctermfg=' . <SID>rgb(a:fg)
    endif
    if a:bg != ''
        exec 'hi ' . a:group . ' guibg=#' . a:bg . ' ctermbg=' . <SID>rgb(a:bg)
    endif
    if a:attr != ''
        exec 'hi ' . a:group . ' gui=' . a:attr . ' cterm=' . a:attr
    endif
endfun
" }}}

" Clear
hi Normal  ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
hi NonText ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" Basic pallette
let s:cool_as_ice    = '6c8b9f'
let s:slate_blue     = '4e5d62'
let s:eggshell_cloud = 'dee5e7'
let s:krasna         = '122B3B'
let s:aluminium1     = 'fefeec'
let s:scarletred2    = 'cc0000'
let s:butter3        = 'c4a000'
let s:go_get_it      = 'B2FD6D'
let s:chilly         = 'A8E1FE'
let s:unicorn        = 'faf6e4'
let s:sandy          = 'F6DD62'
let s:pink_merengue  = 'F696DB'
let s:dune           = 'FFF0A6'
let s:backlit        = '4DF4FF'
let s:schrill        = 'ffb000'
let s:black          = '000000'

let s:yellow         = 'c0c000'

" Global settings
"          Group         Foreground        Background     Mode
call <SID>X('Normal',     s:unicorn,        s:krasna,      ''      )
call <SID>X('Visual',     s:aluminium1,     s:cool_as_ice, ''      )
call <SID>X('Cursor',     s:cool_as_ice,    '',            ''      )
call <SID>X('CursorLine', '',               s:slate_blue,  'none'  )
call <SID>X('StatusLine', '',               s:slate_blue,  ''      )
call <SID>X('LineNr',     '',               s:slate_blue,  ''      )

" Bracket Matching
"          Group         Foreground        Background     Mode
call <SID>X('MatchParen', s:eggshell_cloud, s:butter3,     ''      )

" Comments
"          Group         Foreground        Background     Mode
call <SID>X('Comment',    s:cool_as_ice,    '',            ''      )

" Constants
"          Group         Foreground        Background     Mode
call <SID>X('Constant',   s:pink_merengue,  '',            'bold'  )
call <SID>X('String',     s:dune,           '',            'bold'  )
call <SID>X('SpecialChar',s:backlit,        '',            'bold'  )
call <SID>X('Special',    s:schrill,        '',            'bold'  )

" Identifiers
"          Group         Foreground        Background     Mode
call <SID>X('Identifier', s:chilly,         '',            ''      )

" Statements
"          Group         Foreground        Background     Mode
call <SID>X('Statement',  s:sandy,          '',            'bold'  )

" Types
"          Group         Foreground        Background     Mode
call <SID>X('Type',       s:go_get_it,      '',            ''      )

" Others
"          Group         Foreground        Background     Mode
call <SID>X('PreProc',    s:go_get_it,      '',            'bold'  )
call <SID>X('Error',      s:aluminium1,     s:scarletred2, 'bold'  )
call <SID>X('Todo',       s:slate_blue,     s:unicorn,     'bold'  )
call <SID>X('Underlined', '',               '',            'italic')

call <SID>X('Search',     '',               s:yellow,      ''      )

" vim: set fdl=0 fdm=marker:
