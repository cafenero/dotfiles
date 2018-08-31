#!/bin/bash

. target.sh

for str in ${dotfile_dir[@]}; do
    cp -r ./${str} $HOME/
done

for str in ${dotfile[@]}; do
    cp ./${str} $HOME/
done

if [ ! -e $HOME/.screen ]; then
    mkdir $HOME/.screen
fi

chmod 700 $HOME/.screen

