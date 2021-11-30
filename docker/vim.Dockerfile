# vim.Dockerfile
# 2021/11/6
# entering contianer, do:
# vim, PlugInstall, vim :CocInstall coc-pyright coc-json coc-rust-analyzer coc-snippets
FROM ubuntu:latest 

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

SHELL ["/bin/bash", "-c"] 

# Download maybe painful, so I predownload boost, fzf, ctags, cmake, gflags, glogs, and vim pluggeds. Should remove such Dependency in next version.
COPY . /root/tmp

# build & install g++, cmake, ctags
# build & install rust,clang,llvm,mpi,nodejs
# build & install vim
# build & install oss, zsh
# build & install boost, gflags, glog
# apt install -y clang-format clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python-clang && \
RUN apt update && \
    apt install -y build-essential libssl-dev wget curl git init autotools-dev autoconf pkg-config clang-format clangd mpich && \
    echo 'source $HOME/.cargo/env' >> $HOME/.bashrc && source $HOME/.bashrc && \
    cd ${HOME}/tmp/cmake-* && \
    ./bootstrap && make -j`nproc` && make install && \
    cd ${HOME}/tmp/ctags* && \
    ./autogen.sh && ./configure && make -j`nproc` && make install && \
    cd ${HOME}/tmp/ && \
    curl https://sh.rustup.rs -sSf | bash -s -- -y && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash -&&\
    apt install -y nodejs iputils-ping &&\
    apt install -y vim && \
    apt install -y ccls && \
    apt install -y ripgrep &&\
    mkdir -p ${HOME}/.vim && \
    cd ${HOME}/tmp/vim-conf/script && ./install.sh --vim && \
    cp -rf ${HOME}/tmp/fzf ${HOME}/.fzf && \
    mkdir -p ${HOME}/runtime/bin &&\
    cd ${HOME}/runtime/bin/ &&\
    wget https://gosspublic.alicdn.com/ossutil/1.7.7/ossutil64? -O ossutil &&\
    chmod +x ossutil &&\
    cp -f ${HOME}/tmp/*.sh ${HOME}/runtime/bin/ &&\
    cd ${HOME}/tmp/boost* && ./bootstrap.sh && ./b2 install &&\
    cd ${HOME}/tmp/gflags* && mkdir build && cd build && cmake -DBUILD_SHARED_LIBS=on .. && make -j`nproc` && make install &&\
    cd ${HOME}/tmp/glog* && mkdir build && cd build && cmake .. && make -j`nproc` && make install &&\
    cp -f ${HOME}/tmp/env.sh ${HOME}/ &&\
    rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apk/* &&\
    rm -rf /root/tmp

CMD [ "/sbin/init" ]


