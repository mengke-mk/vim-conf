nmap <silent> <f2> "=HaskellModuleHeader()<CR>:0put =<CR>
function! HaskellModuleHeader(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Module: ")
    let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
    let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")
    
    return  repeat('-', s:width) . "\n" 
    \       . "-- | \n" 
    \       . "-- Module      : " . name . "\n"
    \       . "-- Note        : " . note . "\n"
    \       . "-- \n"
    \       . "-- " . description . "\n"
    \       . "-- \n"
    \       . repeat('-', s:width) . "\n"
    \       . "\n"
endfunction

map <f3> :call AddComment()<cr>
func! AddComment()
    if matchstr(getline('.'), '[^ ]') == '-'
        normal ^xx
    else
        normal ^i--
    endif
endfunc

nmap <silent> <f4> "=HaskellModuleSection()<CR>gp
function! HaskellModuleSection(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Section name: ")

    return  repeat('-', s:width) . "\n"
    \       . "--  " . name . "\n"
    \       . "\n"

endfunction

map <f5> :call CompCpp() <cr>
func! CompCpp()
    exec "! ghc %<.hs -o %<"
endfunc

map <f8> :call ExecCpp() <cr>
func! ExecCpp()
    exec "!  ./%<"
endfunc
