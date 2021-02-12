#!/bin/bash

. target.sh

PWD=$(pwd)

for str in ${dotfile_dir[@]}; do
    #echo "ln -s ${PWD}/${str} $HOME"
    ln -s ${PWD}/${str} $HOME
done

for str in ${dotfile[@]}; do
    #echo "ln -s ${PWD}/${str} $HOME"
    ln -s ${PWD}/${str} $HOME
done

if [ ! -e $HOME/.screen ]; then
    mkdir $HOME/.screen
fi

chmod 700 $HOME/.screen
