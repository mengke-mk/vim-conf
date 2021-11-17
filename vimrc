" The art of doing more with less
" Ke Meng, 2021, vim 8.0+ required

"-------------------------------------------------------------------------------
" Sec-0: Cheating sheet
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Sec-1: Plugins
"-------------------------------------------------------------------------------
" usage: PlugInstall, PlugUpdate, PlugClean, PlugUpgrade (vim-plug itself)
filetype off
call plug#begin('~/.vim/plugged')
" Sec-2: Navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'preservim/tagbar'
" Sec-3: Completion & Syntactic checker
Plug 'ycm-core/YouCompleteMe'
Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'w0rp/ale'
" Sec-4: Search & Jump
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'on': 'Files' }
Plug 'mileszs/ack.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
" Sec-5: Convenience
Plug 'jiangmiao/auto-pairs'
Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'
" Sec-6: Fancy
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
" Sec-7: Specific case
Plug 'gerw/vim-latex-suite'
Plug 'dpelle/vim-LanguageTool'
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
set noshowcmd
set noshowmode
set autochdir
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

"-------------------------------------------------------------------------------
" Sec-2: Navigation
"-------------------------------------------------------------------------------
map <leader>n :NERDTreeToggle<CR>
map <leader>m :TagbarToggle<CR>

"-------------------------------------------------------------------------------
" Sec-3: Completion & syntactic checker
" Current solution: YCM + ALE
"-------------------------------------------------------------------------------
" YCM, YouCompleteMe, a code-completion engine for Vim
" repo: https://github.com/ycm-core/YouCompleteMe
" usage: auto
set completeopt=longest,menu,preview
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"	
let g:ycm_global_ycm_extra_conf='~/includes/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_max_num_candidates = 10
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{3}'],
			\ 'cs,lua,javascript': ['re!\w{3}'],
			\ }
set completeopt=menu,menuone
nnoremap <leader>lo :lopen<CR>	"open locationlist
nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <silent><expr> ( complete_parameter#pre_complete("()")

"-------------------------------------------------------------------------------
" ALE, Asynchronous Lint Engine, an asynchronous syntax checker in vim
" repo: https://github.com/dense-analysis/ale
" usage: <leader>a open/close ale
let g:ale_linters_explicit = 1
    let g:ale_linters = {
\   'cpp': ['cppcheck', 'clang','gcc'],
\   'c': ['cppcheck', 'clang', 'gcc'],
\   'python': ['pylint'],
\   'bash': ['shellcheck'],
\}
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
map ,a ::ALEToggle<CR>
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare

"-------------------------------------------------------------------------------
" Sec-4: Search & Jump
" Current solution: fzf+ack+gutentags
"-------------------------------------------------------------------------------
" fzf, a command-line fuzzy finder
" repo: https://github.com/junegunn/fzf
" usage: <c-p> find file <c-f> fine word
if executable('ag')
  let g:ackprg = 'ag --vimgrep --ignore node_modules --ignore dist'
endif
nmap <c-p> :Gcd<Space><bar><Space>Files<CR>
nmap <c-f> :Gcd<Space><bar><Space>Ack!<Space>

"-------------------------------------------------------------------------------
" ack, a search frontend of ack, a replacement for grep
" repo: https://github.com/mileszs/ack.vim
" usage: Ack [options] {pattern} [{directories}]


"-------------------------------------------------------------------------------
" gutentags, a Vim plugin that manages your tag files, jump to define
" repo: https://github.com/ludovicchabant/vim-gutentags
" usage: <leader>cg for Define | <leader>cs for Refer | <leader>cc for Invoke
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/etc/gtags.conf'
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_auto_add_gtags_cscope = 0

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
" vim-latex-suite, a plugin provides a rich tool for editing latex files
" repo: https://github.com/gerw/vim-latex-suite
" usage: auto in .tex file
set grepprg=grep\ -nH\ $*
let g:Tex_TreatMacViewerAsUNIX = 1
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_UseMakefile=0
let g:Tex_ViewRule_pdf = 'open -a Preview'
nmap <leader>r :e#<CR>

"-------------------------------------------------------------------------------
" LanguageTool, A vim plugin for the LanguageTool grammar checker
" repo: https://github.com/dpelle/vim-LanguageTool
" usage: <leader>g grammer check | <leader>] next error | <leader>[ previous error
let g:languagetool_jar='~/runtime/LanguageTool/languagetool-commandline.jar'
nmap <leader>g :LanguageToolCheck<CR>
nmap <leader>] :lnext<CR>
nmap <leader>[ :lprevious<CR>

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
