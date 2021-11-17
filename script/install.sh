#!/usr/bin/env bash

usage(){
cat <<END
  A script to install vim-conf.

  Usage: ./install [options]
  
  Options:
    -h, --help                  Print help information
    -v, --vim                   Install vim
    -l, --languagetool          Install languagetool
END
}

# install vim
install_vim() {
  set -x
  cp -rf ../vim ~/.vim
  cp -f ../vimrc ~/.vimrc
}

# install languagetool
install_languagetool() {
# download languagetool
wget https://internal1.languagetool.org/snapshots/LanguageTool-latest-snapshot.zip
}

set -e
set -o pipefail

# parse argv
while test $# -ne 0; do
  arg=$1; shift
  case ${arg} in
    -h|--help)        usage; exit ;;
    -v|--vim)         install_vim; exit;; 
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


