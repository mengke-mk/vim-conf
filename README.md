## Motivation
Today's vim plugins are mostly designed to be "awesome" that work pretty well on small projects, however, often fail on large ones. For example: 
- the completion options are polluted by a lot of useless information; 
- unable to jump to the definition of symbols in large project; no support for cross-compilation; 
- unable edit files on remote servers; 
- they cannot check syntax or even search headers. 

**[WIP]** These problems have caused vim to be gradually replaced in real daily work by more mature build tools(IDE). This configuration is designed specially for large projects, removing some flashy plugins and adjusting the parameters of plugins to make vim work as efficiently as the other mainstream IDE on large projects.

## Requirement

- vim 8.0
- clang
- [nerdtree](https://github.com/scrooloose/nerdtree)
- [tagbar](https://github.com/preservim/tagbar)
- [coc.nvim](https://github.com/neoclide/coc.nvim)
- [ale](https://github.com/dense-analysis/ale)
- [fzf](https://github.com/junegunn/fzf)
- [ack](https://github.com/mileszs/ack.vim)
- [gutentags](https://github.com/ludovicchabant/vim-gutentags
)
- [auto-pairs](https://github.com/jiangmiao/auto-pairs)
- [git-blame](https://github.com/zivyangll/git-blame.vim)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [indentLine](https://github.com/Yggdroot/indentLine)
- [lightline](https://github.com/itchyny/lightline.vim)
- [vim-latex-suite](https://github.com/gerw/vim-latex-suite)
- [vim-LanguageTool](https://github.com/dpelle/vim-LanguageTool)
