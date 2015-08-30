#!/bin/bash
cp ./.bashrc $HOME/
cp -r ./.emacs.d $HOME/
cp ./.gitconfig $HOME/
cp ./.gitignore $HOME/
cp ./.screenrc $HOME/
cp ./.tmux.conf $HOME/
cp ./.vimrc $HOME/
if [ ! -e $HOME/.screen ]; then
    mkdir $HOME/.screen
fi
chmod 700 $HOME/.screen
