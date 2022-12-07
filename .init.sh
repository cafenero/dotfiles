#!/bin/bash

TEMP_USER=`whoami`
OS=$(head -n 1 /etc/os-release)

shopt -s expand_aliases
alias sudo='sudo -E '

sudo pwd

case ${OS} in
    *Ubuntu*)
        sudo timedatectl set-timezone Asia/Tokyo
        # general packages
        sudo apt update
        sudo apt -y install \
             emacs-nox tree vim tig ctags htop zsh \
             linux-doc tmux emacs-mozc \
             fzf jq apt-utils debconf-utils \
             wireshark tshark zip fio iotop iftop \
             linux-tools-common linux-tools-generic linux-cloud-tools-generic powertop \
             iperf iperf3

        # snap
        sudo apt install -y snapd
        sudo snap install btop

        # sudo apt -y install docker-compose
        wget https://github.com/gsamokovarov/jump/releases/download/v0.40.0/jump_0.40.0_amd64.deb && sudo dpkg -i jump_0.40.0_amd64.deb && rm jump_0.40.0_amd64.deb

        # docker latest
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update
        sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        sudo systemctl restart docker

        # latest git
        sudo add-apt-repository -y ppa:git-core/ppa
        sudo apt update
        sudo apt -y install git
        sudo chmod 755 /usr/share/doc/git/contrib/diff-highlight/diff-highlight

        # latest golang
        sudo apt install software-properties-common
        sudo add-apt-repository -y ppa:longsleep/golang-backports
        sudo apt update
        sudo apt -y install golang-go

        # gh, ghq, tmux
        # see https://github.com/cli/cli/blob/trunk/docs/install_linux.md
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh
        go install github.com/x-motemen/ghq@latest
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

        # termshark
        # go install github.com/gcla/termshark@latest
        git clone https://github.com/gcla/termshark
        cd termshark
        go install ./...

        # enable non-root packet capture
        sudo debconf-set-selections <<< "wireshark-common wireshark-common/install-setuid boolean true"
        sudo dpkg-reconfigure --frontend noninteractive wireshark-common
        sudo usermod -a -G wireshark $TEMP_USER

        # dev packages
        sudo apt -y install autoconf autogen autopoint libglib2.0-dev libtool xsltproc libsemanage-dev make bison gettext

        # init emacs
        emacs -e 'package-refresh-contents' -e 'package-install-selected-packages' -e 'kill-emacs'
        emacsclient -e '(kill-emacs)'
        ;;
    *CentOS*)
        sudo yum install --enablerepo=epel -y \
             emacs-nox tree vim tig ctags htop \
             kernel-doc mozc libevent libevent-devel ncurses-devel wireshark


        # install latest golang
        wget -O go.tgz "https://go.dev/dl/go1.19.3.linux-amd64.tar.gz"
           sudo tar -C /usr/local -xzf go.tgz && rm go.tgz

        # gh https://github.com/cli/cli/blob/trunk/docs/install_linux.md
        sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo yum install gh

        # install ghq
        # git clone https://github.com/x-motemen/ghq ghq/github.com/x-motemen/ghq
        go install github.com/x-motemen/ghq@latest

        # fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --bin
        rm -rf ~/.fzf

        # termshark
        # go install github.com/gcla/termshark@latest
        git clone https://github.com/gcla/termshark
        cd termshark
        go install ./...


        # IUSを使うパターン
        sudo yum remove -y git
        sudo yum install \
             https://repo.ius.io/ius-release-el7.rpm \
             https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        sudo yum -y install libsecret pcre2
        sudo yum -y install git tmux  --disablerepo=\* --enablerepo=ius
        # emacsがない、、、、、、、、
        # tmux古い、、、2系、、、



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

        # init emacs
        emacs -e 'package-refresh-contents' -e 'package-install-selected-packages' -e 'kill-emacs'
        emacsclient -e '(kill-emacs)'

        ;;
esac
