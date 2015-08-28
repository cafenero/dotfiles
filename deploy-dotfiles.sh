#!/bin/bash
cp ./.bashrc $HOME/
cp -r ./.emacs.d $HOME/
cp ./.gitconfig $HOME/
cp ./.gitignore $HOME/
cp ./.screenrc $HOME/
cp ./.tmux.conf $HOME/
cp ./.vimrc $HOME/
mkdir $HOME/.screen
chmod 700 $HOME/.screen

