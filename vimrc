" The art of doing more with less
" Ke Meng, 2021, vim 8.0+ required
set encoding=utf-8

"-------------------------------------------------------------------------------
" Sec-0: Cheating sheet
"-------------------------------------------------------------------------------
" <leader>n nerdtree
" <leader>m tagbar
" <leader>b git-blame
" <leader>f formatting
" <leader>s easymotion
" <leader>r surround 
" <tab> completion <cr> accept
" [,] jump between errors
" gs goto definition
" K show documentation
" Files, search filename
" Rg, search pattern
" Gstatus
" Gdiff ~1
" Gblame

"-------------------------------------------------------------------------------
" Sec-1: Plugins
"-------------------------------------------------------------------------------
" usage: PlugInstall, PlugUpdate, PlugClean, PlugUpgrade (vim-plug itself)
filetype off
call plug#begin('~/.vim/plugged')
" Sec-2: Navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'preservim/tagbar'
Plug 'tenfyzhong/tagbar-ext.vim'
" Sec-3: Completion & Syntactic checker
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'w0rp/ale'
" Sec-4: Search & Jump
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'on': 'Files' }
Plug 'mileszs/ack.vim'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
" Sec-5: Convenience
Plug 'jiangmiao/auto-pairs'
Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Chiel92/vim-autoformat'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'babaybus/DoxygenToolkit.vim'
Plug 'junegunn/vim-easy-align'
" Sec-6: Fancy
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
" Sec-7: Specific case
"Plug 'gerw/vim-latex-suite'
"Plug 'dpelle/vim-LanguageTool'
call plug#end()

"-------------------------------------------------------------------------------
" Sec-1.1: Basic setting
"-------------------------------------------------------------------------------
" See http://www.guckes.net/vim/setup.html for explanation
set nocp
set nu ru hls nowrap
set noswf ww=<,>
set et sta sw=2 ts=2 sts=2
let mapleader = ","
set backspace=indent,eol,start
set noshowcmd
set noshowmode
set autochdir
set cuc "cul
filetype plugin indent on
syntax on
colo molokai
set guifont=Monaco:h18
if has('gui_runing')
  set lines=35 columns=118
endif 
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set termencoding=utf-8
set tags=./.tags;,.tags
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"-------------------------------------------------------------------------------
" Sec-1.2: Basic mapping 
"-------------------------------------------------------------------------------
noremap<Tab> %
nmap<F11> <c-w>=
nmap<F12> <c-w>\|
map <C-a> ggVG
imap <C-a> <Esc>ggVG
vmap <C-c> "+y
imap <C-v> <Esc>"+p 
" open/close quickfix list
map <leader>o :lopen<CR>
map <leader>c :lclose<CR> 
map <leader>t :tabnew<CR>

"-------------------------------------------------------------------------------
" Sec-2: Navigation
"-------------------------------------------------------------------------------
map <leader>n :NERDTreeToggle<CR>
map <leader>m :TagbarToggle<CR>

"-------------------------------------------------------------------------------
" Sec-3: Completion & syntactic checker
" Current solution: COC
"-------------------------------------------------------------------------------
" coc, conquer of completion, a code-completion engine for Vim
" repo: https://github.com/neoclide/coc.nvim
" usage: <c-space> trigger |<tab> to select |<cr> select first
" the syntactic checker and symbol index in coc are weak
" :Cocconfig
" :CocInstall coc-pyright coc-json coc-rust-analyzer coc-snippets
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=100
set shortmess+=c
set signcolumn=yes
let g:asyncrun_rootmarks = ['.compile_commands.json', '.ccls', '.git']
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use `[` and `]` to navigate diagnostics
nmap <silent> [ <Plug>(coc-diagnostic-prev)
nmap <silent> ] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gs :vsp<CR><Plug>(coc-definition)
nmap <silent> gi :vsp<CR><Plug>(coc-implementation)
nmap <silent> gr :vsp<CR><Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"-------------------------------------------------------------------------------
" (deprecated due to coc)
" ALE, Asynchronous Lint Engine, an asynchronous syntax checker in vim
" repo: https://github.com/dense-analysis/ale
" usage: <leader>a open/close ale
"let g:ale_linters_explicit = 1
"    let g:ale_linters = {
"\   'cpp': ['cppcheck', 'clang','gcc'],
"\   'c': ['cppcheck', 'clang', 'gcc'],
"\   'python': ['pylint'],
"\   'bash': ['shellcheck'],
"\}
"let g:ale_completion_delay = 500
"let g:ale_echo_delay = 20
"let g:ale_lint_delay = 500
"let g:ale_echo_msg_format = '[%linter%] %code: %%s'
"let g:ale_lint_on_text_changed = 'normal'
"let g:ale_lint_on_insert_leave = 1
"let g:airline#extensions#ale#enabled = 1
"let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
"let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
"let g:ale_c_cppcheck_options = ''
"let g:ale_cpp_cppcheck_options = ''
"map ,a ::ALEToggle<CR>
"hi! clear SpellBad
"hi! clear SpellCap
"hi! clear SpellRare

"-------------------------------------------------------------------------------
" Sec-4: Search & Jump
" Current solution: fzf
"-------------------------------------------------------------------------------
" fzf, a command-line fuzzy finder
" repo: https://github.com/junegunn/fzf
let g:fzf_layout = {'down': '~30%'}

"-------------------------------------------------------------------------------
" (deprecated due to fzf)
" ack, a search frontend of ack, a replacement for grep
" repo: https://github.com/mileszs/ack.vim
" usage: Ack [options] {pattern} [{directories}]

"-------------------------------------------------------------------------------
" (deprecated due to coc)
" gutentags, a Vim plugin that manages your tag files, jump to define
" repo: https://github.com/ludovicchabant/vim-gutentags
" usage: <leader>cg for Define | <leader>cs for Refer | <leader>cc for Invoke
" let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/etc/gtags.conf'
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" let g:gutentags_ctags_tagfile = '.tags'
" let g:gutentags_modules = []
" if executable('ctags')
" 	let g:gutentags_modules += ['ctags']
" endif
" if executable('gtags-cscope') && executable('gtags')
" 	let g:gutentags_modules += ['gtags_cscope']
" endif
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" let g:gutentags_auto_add_gtags_cscope = 0

"-------------------------------------------------------------------------------
" Sec-5: Convenience
"-------------------------------------------------------------------------------
" auto-pair, a plugin to insert or delete brackets, parens, quotes in pair
" repo: https://github.com/jiangmiao/auto-pairs
" usage: auto
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent>) <C-R>=AutoPairsInsert(')')<CR>
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''

"-------------------------------------------------------------------------------
" git-blame, see git blame info in the status bar for the selected line.
" repo: https://github.com/zivyangll/git-blame.vim
" usage: <leader>b to blame
map <leader>b :<C-u>call gitblame#echo()<CR>

"-------------------------------------------------------------------------------
" vim-fugitive, A Git wrapper
" repo: https://github.com/tpope/vim-fugitive
" usage: :Git <git command>

"-------------------------------------------------------------------------------
" vim-autoformat, Provide easy code formatting in Vim
" repo: https://github.com/vim-autoformat/vim-autoformat
" usage: <leader>f (require .clang-format in your project root)
noremap <leader>f :Autoformat<CR>

"-------------------------------------------------------------------------------
" easymotion, vim motions on speed
" repo: https://github.com/easymotion/vim-easymotion
" usage: <leader>s
map <leader> <Plug>(easymotion-prefix)

"-------------------------------------------------------------------------------
" vim-surround, Delete/change/add parentheses/quotes/XML-tags/much more with ease 
" repo: https://github.com/tpope/vim-surround
" usage: ysiw( to surround | cs([ to change | ds( to delete
nmap <leader>r ysiw

"-------------------------------------------------------------------------------
" DoxygenToolkit.vim, Simplify Doxygen documentation in C, C++, Python.
" repo: https://github.com/babaybus/DoxygenToolkit.vim
" usage: :Dox 
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Ke Meng"
let g:DoxygenToolkit_licenseTag="MIT"

"-------------------------------------------------------------------------------
" vim-easy-align, A Vim alignment plugin
" repo: https://github.com/junegunn/vim-easy-align
" usage: gaip*= gaip1 gaip*|
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"-------------------------------------------------------------------------------
" Sec-6: Fancy
"-------------------------------------------------------------------------------
" lightline, A light and configurable statusline/tabline plugin for Vim
" repo: https://github.com/itchyny/lightline.vim
" usage: auto
set laststatus=2
let g:lightline = {'colorscheme': 'wombat',}

"-------------------------------------------------------------------------------
" indentLine, A vim plugin to display the indention levels with thin vertical lines
" repo: https://github.com/Yggdroot/indentLine
" usage: auto

"-------------------------------------------------------------------------------
" Sec-7: Specific case
"-------------------------------------------------------------------------------
" (latex-only)
" vim-latex-suite, a plugin provides a rich tool for editing latex files
" repo: https://github.com/gerw/vim-latex-suite
" usage: auto in .tex file
" set grepprg=grep\ -nH\ $*
" let g:Tex_TreatMacViewerAsUNIX = 1
" let g:tex_flavor='latex'
" let g:Tex_DefaultTargetFormat='pdf'
" let g:Tex_UseMakefile=0
" let g:Tex_ViewRule_pdf = 'open -a Preview'
" nmap <leader>r :e#<CR>

"-------------------------------------------------------------------------------
" (latex-only)
" LanguageTool, A vim plugin for the LanguageTool grammar checker
" repo: https://github.com/dpelle/vim-LanguageTool
" usage: <leader>g grammer check | <leader>] next error | <leader>[ previous error
" let g:languagetool_jar='~/runtime/LanguageTool/languagetool-commandline.jar'
" nmap <leader>g :LanguageToolCheck<CR>
" nmap <leader>] :lnext<CR>
" nmap <leader>[ :lprevious<CR>

"-------------------------------------------------------------------------------
" filetype-extension, customized mapping for differetn language
autocmd filetype c,cu,cpp source $HOME/.vim/lang/cplus.vim
autocmd filetype python source $HOME/.vim/lang/python.vim
autocmd filetype markdown source $HOME/.vim/lang/markdown.vim
autocmd filetype lua source $HOME/.vim/lang/lua.vim
autocmd filetype haskell source $HOME/.vim/lang/haskell.vim
autocmd filetype tex source $HOME/.vim/lang/tex.vim
autocmd filetype make set noexpandtab ts=4 sts=4 sw=4 "makefile tab"
autocmd filetype make set noexpandtab "makefile tab != 4bk"
