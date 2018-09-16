noremap <f6> =a{

map <f2> :call SetTitle()<CR>Gkkk
func! SetTitle()
let l = 0
let l = l + 1 | call setline(l, '/*')
let l = l + 1 | call setline(l, ' * Author:  MK')
let l = l + 1 | call setline(l, ' * Created Time:  '.strftime('%c'))
let l = l + 1 | call setline(l, ' * File Name: '.expand('%'))
let l = l + 1 | call setline(l, ' */')
let l = l + 1 | call setline(l, '#include <bits/stdc++.h>')
let l = l + 1 | call setline(l, 'using namespace std;')
let l = l + 1 | call setline(l, 'int main() {')
let l = l + 1 | call setline(l, '  return 0;')
let l = l + 1 | call setline(l, '}')
let l = l + 1 | call setline(l, '')
endfunc

map <f3> :call AddComment()<cr>
func! AddComment()
    if matchstr(getline('.'), '[^ ]') == '/'
        normal ^xx
    else
        normal ^i//
    endif
endfunc

map <f4> :call SaveInputData() <cr>
func! SaveInputData()
    exec "tabnew"
    exec 'normal"+gP'
    exec "w! input.in"
endfunc

map <f5> :call CompCpp() <cr>
func! CompCpp()
    exec "! g++-4.9 -std=c++11 % -o %<"
endfunc

map <c-f5> : call CompC() <cr>
func! CompC()
    exec "! gcc-4.9 % -o %<"
endfunc

map <f8> :call ExecCpp() <cr>
func! ExecCpp()
    exec "!  ./%<"
endfunc

map <c-f8> :call ExcCppWithInput() <cr>
func! ExcCppWithInput()
    exec "!  ./%< < input.in"
endfunc
