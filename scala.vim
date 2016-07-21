map <f2> :call SetTitlescala()<CR>gg
func! SetTitlescala()
let l = 0
let l = l + 1 | call setline(l,'/*')
let l = l + 1 | call setline(l,' * Author   : septicmk')
let l = l + 1 | call setline(l,' * Date     : '.strftime("%Y/%m/%d %H:%M:%S"))
let l = l + 1 | call setline(l,' * FileName : '.expand('%'))
let l = l + 1 | call setline(l,'*/')
let l = l + 1 | call setline(l,'')
endfunc

map <f3> :call AddComment()<cr>
func! AddComment()
    if matchstr(getline('.'), '[^ ]') == '/'
        normal ^xx
    else
        normal ^i//
    endif
endfunc

map <f5> :call CompScala() <cr>
func! CompScala()
    exec "! scalac %<.scala"
endfunc

map <f8> :call ExecScala() <cr>
func! ExecScala()
    exec "! scala %<"
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
