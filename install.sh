#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim
ln -s $(pwd)/emacs $HOME/.emacs
ln -s $(pwd)/screenrc $HOME/.screenrc
rm -f $HOME/.zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/bash_profile $HOME/.bash_profile

sudo apt-get --assume-yes install silversearcher-ag bat
vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"
