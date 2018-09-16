map <f2> :call SetTitlepy()<CR>gg
func! SetTitlepy()
let l = 0
let l = l + 1 | call setline(l,'#|')
let l = l + 1 | call setline(l,' Author   : septicmk')
let l = l + 1 | call setline(l,' Date     : '.strftime("%Y/%m/%d %H:%M:%S"))
let l = l + 1 | call setline(l,' FileName : '.expand('%'))
let l = l + 1 | call setline(l,'|#')
let l = l + 1 | call setline(l,'')
endfunc

map <f3> :call AddComment()<cr>
func! AddComment()
    if matchstr(getline('.'), '[^ ]') == ';'
        normal ^xx
    else
        normal ^i;;
    endif
endfunc


map <f8> :call Racket_Run()<cr>
func! Racket_Run()
    exec "! racket %<.rkt"
endfunc
