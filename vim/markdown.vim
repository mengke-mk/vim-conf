map <f2> :call SetTitlepy()<CR>gg
func! SetTitlepy()
let l = 0
let l = l + 1 | call setline(l,'title: ' .expand("%"))
let l = l + 1 | call setline(l,'date: ' .strftime("%Y/%m/%d"))
let l = l + 1 | call setline(l,'shortcut: ' .expand("%"))
let l = l + 1 | call setline(l,'categories: draft')
let l = l + 1 | call setline(l,'tags: none')
let l = l + 1 | call setline(l,'---')
let l = l + 1 | call setline(l,'')
endfunc

