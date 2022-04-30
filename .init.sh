#!/bin/bash

OS=$(head -n 1 /etc/os-release)
case ${OS} in
    *Ubuntu*)
        sudo apt -y install \
             git emacs-nox tree vim tig ctags htop \
             linux-doc tmux emacs-mozc \
             golang termshark fzf docker-compose
        wget https://github.com/gsamokovarov/jump/releases/download/v0.40.0/jump_0.40.0_amd64.deb && sudo dpkg -i jump_0.40.0_amd64.deb && rm jump_0.40.0_amd64.deb
        go install github.com/x-motemen/ghq
        emacs -e 'package-refresh-contents' -e 'kill-emacs'
        emacs -e 'package-install-selected-packages'
        # emacs -e 'package-install-selected-packages' -e 'y'
        ;;
    *CentOS*)
        sudo yum install --enablerepo=epel -y \
             git emacs-nox tree vim tig ctags htop \
             kernel-doc mozc
        if [ -e ~/tmux.tar.gz ]; then
            tar xf tmux.tar.gz
            cd tmux
            sudo make install
            cd
        fi
        if [ -e ~/emacs-27.2-build-nox-tls.tar.gz ]; then
            tar xf emacs-27.2-build-nox-tls.tar.gz
            cd emacs-27.2
            sudo make install
            cd
        fi
        ;;
esac
