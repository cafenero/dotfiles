#!/bin/bash

. ./target.sh
PWD=$(pwd)
FLAG_FORCED=0

while getopts fad:h OPT
do
    case $OPT in
        f)  FLAG_FORCED=1
            ;;
    esac
done


if [ ${FLAG_FORCED} == 1 ]; then
	echo  "Forced overwrite!!! "
fi

# file
for str in ${dotfile[@]}; do
	echo "ln -s ${PWD}/${str} $HOME"
    if [ ${FLAG_FORCED} == 1 ]; then
		rm $HOME/${str}
		ln -s ${PWD}/${str} $HOME
    else
		ln -s ${PWD}/${str} $HOME
    fi
done

# directory
for str in ${dotfile_dir[@]}; do
	echo "ln -s ${PWD}/${str} $HOME"
    if [ ${FLAG_FORCED} == 1 ]; then
		rm -rf $HOME/${str}
		ln -s ${PWD}/${str} $HOME
    else
		ln -s ${PWD}/${str} $HOME
    fi
done


# etc
if [ ! -e $HOME/.screen ]; then
    mkdir $HOME/.screen
    chmod 700 $HOME/.screen
fi
