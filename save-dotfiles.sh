#!/bin/bash

. target.sh

for str in ${dotfile_dir[@]}; do
    cp -r $HOME/${str} $HOME/dotfiles/
done

for str in ${dotfile[@]}; do
    cp $HOME/${str} $HOME/dotfiles/
done
