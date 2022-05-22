#!/bin/bash

OS=$(head -n 1 /etc/os-release)
case ${OS} in
    *Ubuntu*)
        # general packages
        sudo apt -y install \
             git emacs-nox tree vim tig ctags htop \
             linux-doc tmux emacs-mozc \
             termshark fzf docker-compose
        wget https://github.com/gsamokovarov/jump/releases/download/v0.40.0/jump_0.40.0_amd64.deb && sudo dpkg -i jump_0.40.0_amd64.deb && rm jump_0.40.0_amd64.deb

        # golang
        sudo add-apt-repository -y ppa:longsleep/golang-backports
        sudo apt update
        sudo apt -y install golang-go

        # tools: gh, ghq, tmux
        # see https://github.com/cli/cli/blob/trunk/docs/install_linux.md
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh
        go install github.com/x-motemen/ghq@latest
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

        # dev packages
        sudo apt -y install autoconf autogen autopoint libglib2.0-dev libtool xsltproc libsemanage-dev make bison gettext

        # emacs init
        emacs -e 'my-allinstall' -e 'kill-emacs'
        ;;
    *CentOS*)
        sudo yum install --enablerepo=epel -y \
             git emacs-nox tree vim tig ctags htop \
             kernel-doc mozc
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
