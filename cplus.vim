noremap <f6> =a{


map <f2> :call USACO()<CR>Gkkk
func! USACO()
    let l = 0
    let l = l + 1 | call setline(l, '/*')
    let l = l + 1 | call setline(l, 'ID: septicmk')
    let l = l + 1 | call setline(l, 'LANG: C++')
    let l = l + 1 | call setline(l, 'TASK: ')
    let l = l + 1 | call setline(l, '*/')
    let l = l + 1 | call setline(l, '')
    let l = l + 1 | call setline(l, 'int main() {')
    let l = l + 1 | call setline(l, '    return 0;')
    let l = l + 1 | call setline(l, '}')
    let l = l + 1 | call setline(l, '')
endfunc

map <c-f2> :call SetTitle()<CR>Gkkk
func! SetTitle()
let l = 0
let l = l + 1 | call setline(l, '/*')
let l = l + 1 | call setline(l, ' * Author:  MK')
let l = l + 1 | call setline(l, ' * Created Time:  '.strftime('%c'))
let l = l + 1 | call setline(l, ' * File Name: '.expand('%'))
let l = l + 1 | call setline(l, ' */')
let l = l + 1 | call setline(l, '#include <iostream>')
let l = l + 1 | call setline(l, '#include <cstdio>')
let l = l + 1 | call setline(l, '#include <cstring>')
let l = l + 1 | call setline(l, '#include <cmath>')
let l = l + 1 | call setline(l, '#include <algorithm>')
let l = l + 1 | call setline(l, '#include <vector>')
let l = l + 1 | call setline(l, 'using namespace std;')
let l = l + 1 | call setline(l, '#define out(v) cerr << #v << ": " << (v) << endl')
let l = l + 1 | call setline(l, '#define lint long long')
let l = l + 1 | call setline(l, 'const int inf = -1u>>1;')
let l = l + 1 | call setline(l, '')
let l = l + 1 | call setline(l, 'int main() {')
let l = l + 1 | call setline(l, '    return 0;')
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
    exec "! g++ %<.cpp -o %<"
endfunc

map <c-f5> : call CompC() <cr>
func! CompC()
    exec "! gcc %<.c -o %<"
endfunc

map <f8> :call ExecCpp() <cr>
func! ExecCpp()
    exec "!  ./%<"
endfunc

map <c-f8> :call ExcCppWithInput() <cr>
func! ExcCppWithInput()
    exec "!  ./%< < input.in"
endfunc

map <f9> :TlistToggle<CR><CR>


inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunc

function! CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endfunc

function! QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        "Inserting a quoted quotation mark into the string
        return a:char
    elseif line[col - 1] == a:char
        "Escaping out of the string
    return "\<Right>"
    else
        "Starting a string
    return a:char.a:char."\<Esc>i"
    endif
endfunc
