#!/bin/bash

. target.sh

for str in ${dotfile_dir[@]}; do
    rsync -a $HOME/${str} $HOME/dotfiles/
done
cp $HOME/.gitignore ./saved_dot_ignore

for str in ${dotfile[@]}; do
    cp $HOME/${str} $HOME/dotfiles/${str}
done
