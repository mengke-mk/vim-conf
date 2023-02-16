" The art of doing more with less
" Ke Meng, 2023, vim 8.0+/nvim 0.8+ required
set encoding=utf-8
set runtimepath^=~/.vim runtimepath+=~/.vim/after

"-------------------------------------------------------------------------------
" Sec-0: Cheating sheet
"-------------------------------------------------------------------------------
" <leader>n nvimtree
" <leader>m vista
" <leader>b git-blame
" <leader>l format
" <leader>f telescope
" <leader>s easymotion
" <leader>r surround 
" <tab> completion <cr> accept
" [,] jump between errors
" gs goto definition
" K show documentation
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
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'liuchengxu/vista.vim'
" Sec-3: Completion & Syntactic checker
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'm-pilia/vim-ccls'
" Sec-4: Search & Jump
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
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
Plug 'tpope/vim-abolish'
Plug 'github/copilot.vim'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/sonokai'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'wfxr/minimap.vim'
call plug#end()

let g:python3_host_prog="/usr/bin/python3"

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
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colo onehalfdark
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
map <leader>o :lopen<CR>
map <leader>c :lclose<CR> 
map <leader>t :tabnew<CR>
nmap <BS> :e#<CR>

"-------------------------------------------------------------------------------
" Sec-2: Navigation
"-------------------------------------------------------------------------------
lua require'nvim-tree'.setup {}
map <leader>n :NvimTreeToggle<CR>
map <leader>m :MinimapToggle<CR>	
map <leader>p :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_sidebar_width = 32
let g:vista#renderer#enable_icon = 1
let g:vista_executive_for = {
  \ 'cpp': 'coc',
  \ 'c': 'coc',
  \ 'cuda': 'coc',
  \ }

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
nmap <silent> gs <Plug>(coc-definition)
"nmap <silent> gi :vsp<CR><Plug>(coc-implementation)
"nmap <silent> gr :vsp<CR><Plug>(coc-references)

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

" config of vim-lsp
let g:ccls_close_on_jump = v:true
let g:ccls_size = 50
let g:ccls_position = 'botright'
let g:ccls_orientation = 'horizontal'

nmap <leader>1 :CclsCalleeHierarchy<CR>
nmap <leader>2 :CclsCallHierarchy<CR>
nmap <leader>3 :CclsDerivedHierarchy<CR>
nmap <leader>4 :CclsBaseHierarchy<CR>

"-------------------------------------------------------------------------------
" Sec-4: Search & Jump
" Current solution: fzf
"-------------------------------------------------------------------------------
" Telescope, Find, Filter, Preview, Pick. All lua, all the time.
" https://github.com/nvim-telescope/telescope.nvim
nmap <leader>f <cmd>Telescope live_grep<cr>

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
" vim-autoformat, Provide easy code formatting in Vim
" repo: https://github.com/vim-autoformat/vim-autoformat
" usage: <leader>l (require .clang-format in your project root)
noremap <leader>l :Autoformat<CR>

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
let g:lightline = {'colorscheme': 'onehalfdark',}

"-------------------------------------------------------------------------------
" indentLine, A vim plugin to display the indention levels with thin vertical lines
" repo: https://github.com/Yggdroot/indentLine
" usage: auto
