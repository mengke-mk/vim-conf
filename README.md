## Introduction

This is an out-of-the-box `nvim-dev` image (~1 min to build), contains almost everything you need like LSP-client (coc), LSP-server (ccls), file navigation (nvim-tree), search (greprip, telescope), copilot, git-integration, and other fancy stuffs. 
We also maintain a single-file high-quality version in pure Lua to continuously integrate the ever-evolving nvim plugins `init.lua`.

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
