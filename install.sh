#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim
ln -s $(pwd)/emacs $HOME/.emacs
ln -s $(pwd)/screenrc $HOME/.screenrc
ln -s $(pwd)/zshrc $HOME/.zshrc

sudo apt-get --assume-yes install silversearcher-ag bat
vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"
