""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'vimwiki/vimwiki'
Plugin 'derekwyatt/vim-scala'
Plugin 'wlangstroth/vim-racket'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"surround 
"Normal mode
"-----------
"ds  - delete a surrounding
"cs  - change a surrounding
"ys  - add a surrounding
"yS  - add a surrounding and place the surrounded text on a new line + indent it
"yss - add a surrounding to the whole line
"ySs - add a surrounding to the whole line, place it on a new line + indent it
"ySS - same as ySs
"
"Visual mode
"-----------
"s   - in visual mode, add a surrounding
"S   - in visual mode, add a surrounding but place text on new line + indent it
"
"Insert mode
"-----------
"<CTRL-s> - in insert mode, add a surrounding
"<CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent
"<CTRL-g>s - same as <CTRL-s>
"<CTRL-g>S - same as <CTRL-s><CTRL-s>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    colo molokai
else
    colo desert
    set ttimeoutlen=100
endif
set ru nu hls ar sw=4 ts=4 noswf et sta nowrap ww=<,>,[,]
set expandtab
" set guifont=DejaVu\ Sans\ Mono\ 16
set guifont=Monaco\ 18
syn on
" filetype indent on
" filetype plugin on
set tags=tags
set autochdir
set printoptions=syntax:n,number:y,portrait:y
set guioptions+=b
set fencs=utf-8,utf-16,gbk,gb2312,gb18030,cp936,ucs-bom,latin1,BIG5
set guioptions-=T
let mapleader = ","
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动补全配置
set completeopt=longest,menu,preview	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项

let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let ycm_autoclose_preview_window_after_insertion=1
"let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
"nnoremap <leader>lo :lopen<CR>	"open locationlist
"nnoremap <leader>lc :lclose<CR>	"close locationlist
"inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
let g:ycm_register_as_syntastic_checker = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 语法检测配置
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { "mode": "active",
                           \ "active_filetypes": [],
                           \ "passive_filetypes": ["scala","racket"] }
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "X"
let g:syntastic_warning_symbol = "!"
let g:syntastic_style_error_symbol = ">"
let g:syntastic_style_warning_symbol = ">"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimwiki
" 多个维基项目的配置
"      \ 'html_header': 'E:/My Dropbox/Public/vimwiki_template/header.htm',
"      \ 'html_footer': 'E:/My Dropbox/Public/vimwiki_template/footer.htm',
"      \ 'diary_link_count': 5},
let g:vimwiki_list = [{'path': '~/wiki/miki/',
                    \   'template_path': '~/wiki/templates',
                    \   'template_default': 'post',
                    \   'template_ext': '.html'}]
" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 我的 vim 是没有菜单的，加一个 vimwiki 菜单项也没有意义
let g:vimwiki_menu = ''
map <leader>m <Plug>VimwikiToggleListItem
" 是否开启按语法折叠  会让文件比较慢
"let g:vimwiki_folding = 1
" 是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_CJK_length = 1
" 使其支持html原生代码
" let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>n :NERDTreeToggle<CR>

map <C-t> :tabnew<CR>
map <C-a> ggVG
imap <C-a> <Esc>ggVG
vmap <C-c> "+y
imap <C-v> <Esc>"+p
map <C-l> :call ToggleCursor()<CR>
func! ToggleCursor()
    if &cursorcolumn
        set nocursorcolumn nocursorline
    else
        set cursorcolumn cursorline
    endif
endfunc
nmap <F9> :TagbarToggle<CR>

autocmd filetype make set noexpandtab "makefile tab != 4bk"

autocmd filetype c,cpp source $VIMRUNTIME/cplus.vim
autocmd filetype python source $VIMRUNTIME/python.vim
autocmd filetype wiki source $VIMRUNTIME/wiki.vim
autocmd filetype markdown source $VIMRUNTIME/markdown.vim
autocmd filetype scala source $VIMRUNTIME/scala.vim
autocmd filetype lua source $VIMRUNTIME/lua.vim
autocmd filetype racket source $VIMRUNTIME/racket.vim
autocmd filetype haskell source $VIMRUNTIME/haskell.vim

