## Introduction

This is an out-of-the-box `nvim-dev` image (~1 min to build), contains almost everything you need like LSP-client (coc), LSP-server (ccls), file navigation (nvim-tree), search (greprip, telescope), copilot, git-integration, and other fancy stuffs. The configuration is intuitive and clean, and the `init.nvim` is detailedly annotated and is easy-to-extend.


## Usage

To build this `nvim-dev` image:

```
 docker build -t nvim-dev:latest -f vim.Dockerfile  .
```

Then create a development environment to code, build, and run:

```
docker run -itd --shm-size=16384m \
      -v <your codebase>:<codebase mapping e.g.:/mnt/project> \
      --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
      nvim-dev:latest \
      /bin/bash
```

And attach to your `nvim-dev`:

```
docker exec -it -e "TERM=screen-256color" <your container ID> /bin/bash
```

## Thanks

Do not forget to star these aewsome vim plugins:

- kyazdani42/nvim-web-devicons
- kyazdani42/nvim-tree.lua
- liuchengxu/vista.vim
- neoclide/coc.nvim
- m-pilia/vim-ccls
- nvim-lua/plenary.nvim
- nvim-telescope/telescope.nvim
- jiangmiao/auto-pairs
- zivyangll/git-blame.vim
- tpope/vim-fugitive
- airblade/vim-gitgutter
- Chiel92/vim-autoformat
- easymotion/vim-easymotion
- tpope/vim-surround
- babaybus/DoxygenToolkit.vim
- junegunn/vim-easy-align
- tpope/vim-abolish
- github/copilot.vim
- Yggdroot/indentLine
- itchyny/lightline.vim
- sainnhe/sonokai
- sonph/onehalf
- wfxr/minimap.vim
