set ts=4 sts=4 sw=4
map <f2> :call SetTitlepy()<CR>gg
func! SetTitlepy()
let l = 0
let l = l + 1 | call setline(l,'# -*- coding: utf-8 -*-')
let l = l + 1 | call setline(l,'"""')
let l = l + 1 | call setline(l,'Date     : '.strftime("%Y/%m/%d %H:%M:%S"))
let l = l + 1 | call setline(l,'FileName : '.expand('%'))
let l = l + 1 | call setline(l,'Author   : septicmk')
let l = l + 1 | call setline(l,'"""')
let l = l + 1 | call setline(l,'')
endfunc

map <f3> :call AddComment()<cr>
func! AddComment()
    if matchstr(getline('.'), '[^ ]') == '#'
        normal ^x
    else
        normal ^i#
    endif
endfunc

map <f6> <Esc>gg=G<CR>

map <f8> :call Python_Run()<cr>
func! Python_Run()
    exec "! python %<.py"
endfunc
