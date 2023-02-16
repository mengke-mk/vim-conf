# vim.Dockerfile
# 2023/2/16
FROM ubuntu:latest 

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

SHELL ["/bin/bash", "-c"] 

RUN apt-get update && \
    apt install -y software-properties-common && \
    apt install -y build-essential lsb-release libssl-dev wget curl git init autotools-dev autoconf pkg-config clang-format clangd cmake &&\
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt-get update &&\
    apt-get install -y neovim &&\
    curl -sL https://deb.nodesource.com/setup_14.x | bash - &&\
    apt install -y nodejs iputils-ping ccls ripgrep python3-pip &&\
    apt install -y -o Dpkg::Options::="--force-overwrite" bat &&\
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
    pip install --upgrade --force-reinstall neovim --user &&\
    git clone https://github.com/septicmk/vim-conf.git && \
    mkdir -p ~/.config/nvim/ && cp vim-conf/init.vim ~/.config/nvim/ && cp vim-conf/coc-settings.json ~/.config/nvim/ &&\
    rm -rf vim-conf &&\
    nvim +'PlugInstall --sync' +qa &&\
    nvim +'CocInstall -sync coc-pyright coc-json coc-rust-analyzer coc-snippets' +qall && nvim +CocUpdateSync +qall &&\
    rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apk/* &&\
    rm -rf /root/tmp

CMD [ "/sbin/init" ]


