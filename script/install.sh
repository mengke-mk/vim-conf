#!/usr/bin/env bash

PLATFORM=
OS_VERSION=

usage(){
cat <<END
  A script to install vim-conf.

  Usage: ./install [options]
  
  Options:
    -h, --help                  Print help information
    -v, --vim                   Install vim
    -l, --languagetool          Install languagetool
    -d, --dep                   Install dependency
END
}

get_os_version() {
  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    PLATFORM="${NAME}"
    OS_VERSION="${VERSION_ID}"
  elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    PLATFORM=$(lsb_release -si)
    OS_VERSION=$(lsb_release -sr)
  elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    PLATFORM="${DISTRIB_ID}"
    OS_VERSION="${DISTRIB_RELEASE}"
  elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    PLATFORM=Debian
    OS_VERSION=$(cat /etc/debian_version)
  elif [ -f /etc/centos-release ]; then
    # Older Red Hat, CentOS, etc.
    PLATFORM=CentOS
    OS_VERSION=$(cat /etc/centos-release | sed 's/.* \([0-9]\).*/\1/')
  else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, Darwin, etc.
    PLATFORM=$(uname -s)
    OS_VERSION=$(uname -r)
  fi
  readonly PLATFORM
  readonly OS_VERSION
}

# install vim
install_vim() {
  set -x
  cp -rf ../vim/* ~/.vim/
  cp -f ../vimrc ~/.vimrc
}

# install languagetool
install_languagetool() {
# download languagetool
  wget https://internal1.languagetool.org/snapshots/LanguageTool-latest-snapshot.zip
}

install_dep() {
  get_os_version

  if [[ "${PLATFORM}" == *"Ubuntu"* ]]; then
    sudo apt install snapd
    sudo snap install ccls --classic
    sudo apt-get install rust
    cargo install ripgrep
  elif [[ "${PLATFORM}" == *"Darwin"* ]]; then
    brew install ccls
    brew install ripgrep
  fi
}


set -e
set -o pipefail

# parse argv
while test $# -ne 0; do
  arg=$1; shift
  case ${arg} in
    -h|--help)        usage; exit ;;
    -v|--vim)         install_vim; exit;; 
    -d|--dep)         install_dep; exit;; 
    -l|--languagetool) install_languagetool; exit;;
    *)
      echo "unrecognized option or command '${arg}'"
      uasge; exit 1;;
  esac
done
if test $# -eq 0; then
  usage
fi
set +e
set +o pipefail


