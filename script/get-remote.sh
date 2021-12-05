#!/bin/bash

function check_dir() {
    for i in `ls -d */`
    do
        cd $i
        if [ -d .git ];then
            # echo $i
            git remote get-url origin
            # git remote -v
        else
            check_dir
        fi
        cd ..
    done
}

check_dir
