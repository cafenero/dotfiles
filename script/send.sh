#!/bin/bash
#-ue

OPT_FLAG_FILE=0
OPT_ALL=0
OPT_FLAG_FORCE=0
OPT_FLAG_TOOLS=0
while getopts "fyt" OPT
do
    echo "hoge"
    case $OPT in
        f) OPT_FLAG_FILE=1;;
        y) OPT_FLAG_FORCE=1;;
        t) OPT_FLAG_TOOLS=1;;
    esac
done

# echo $1
# echo $OPT_FLAG_TOOLS
# exit

if [ $OPT_FLAG_FILE == 1 ]; then
    while read line
    do
        rsync -az --copy-links -e "ssh" ~/.zshrc $line:
        rsync -az --copy-links -e "ssh" ~/.office.zsh $line:
        rsync -az --copy-links -e "ssh" ~/.tmux.conf $line:
        rsync -az --copy-links -e "ssh" ~/.gitconfig $line:
        rsync -az --copy-links -e "ssh" ~/.gitignore $line:
        rsync -az --copy-links -e "ssh" ~/.emacs.d $line:
        rsync -az --copy-links -e "ssh" ~/.init.sh $line:
        rsync -az --copy-links -e "ssh" ~/bin $line:
        rsync -az --copy-links -e "ssh" ~/.gitconfig.local $1:
        rsync -az --copy-links -e "ssh" ~/.vimrc $1:
    done < $2
else
    rsync -az --copy-links -e "ssh" ~/.zshrc $1:
    rsync -az --copy-links -e "ssh" ~/.office.zsh $1:
    rsync -az --copy-links -e "ssh" ~/.tmux.conf $1:
    rsync -az --copy-links -e "ssh" ~/.gitconfig $1:
    rsync -az --copy-links -e "ssh" ~/.gitignore $1:
    rsync -az --copy-links -e "ssh" ~/.emacs.d/init.el   $1:~/.emacs.d/
    rsync -az --copy-links -e "ssh" ~/.emacs.d/custom.el $1:~/.emacs.d/
    rsync -az --copy-links -e "ssh" ~/.init.sh $1:
    rsync -az --copy-links -e "ssh" ~/bin $1:
    rsync -az --copy-links -e "ssh" ~/.gitconfig.local $1:
    rsync -az --copy-links -e "ssh" ~/.vimrc $1:

    if [ $OPT_FLAG_TOOLS == 1 ]; then
        ret=$(echo $1 | egrep -e "kvm|ynwp|os-ctl|master")
        if [ $OPT_FLAG_FORCE == 1 ] || [ -z "${ret}" ]; then
            ## not for prod server
            if [ -e ~/emacs-27.2-build-nox-tls.tar.gz ]; then
                echo "emacs-27.2-build-nox-tls.tar.gz"
                rsync -az -e "ssh" ~/emacs-27.2-build-nox-tls.tar.gz $1:
            fi
            if [ -e ~/tmux.tar.gz ]; then
                echo "tmux.tar.gz"
                rsync -az -e "ssh" ~/tmux.tar.gz $1:
            fi
        fi
    fi

fi
