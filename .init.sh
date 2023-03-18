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
             tree vim tig ctags htop zsh \
             linux-doc \
             fzf jq apt-utils debconf-utils \
             wireshark tshark zip fio iotop iftop \
             linux-tools-common linux-tools-generic linux-cloud-tools-generic powertop \
             iperf iperf3 shellcheck

        wget https://github.com/cafenero/build_own_packages/releases/download/2023-03-16-tmux-deb/tmux_3.3-2023-03-16-19-58_amd64.deb
        wget https://github.com/cafenero/build_own_packages/releases/download/2023-03-16-emacs-deb/emacs_28.2-2023-03-16-19-58_amd64.deb
        sudo apt install -y ./emacs_28.2-2023-03-16-19-58_amd64.deb ./tmux_3.3-2023-03-16-19-58_amd64.deb emacs-mozc
        rm ./emacs_28.2-2023-03-16-19-58_amd64.deb ./tmux_3.3-2023-03-16-19-58_amd64.deb


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

        # gh, ghq
        # see https://github.com/cli/cli/blob/trunk/docs/install_linux.md
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh
        go install github.com/x-motemen/ghq@latest

        # tmux
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

        # termshark
        # go install github.com/gcla/termshark@latest
        git clone https://github.com/gcla/termshark
        cd termshark
        go install ./...
        cd ..
        rm -rf termshark

        # enable non-root packet capture
        sudo debconf-set-selections <<< "wireshark-common wireshark-common/install-setuid boolean true"
        sudo dpkg-reconfigure --frontend noninteractive wireshark-common
        sudo usermod -a -G wireshark $TEMP_USER

        # dev packages
        sudo apt -y install autoconf autogen autopoint libglib2.0-dev libtool xsltproc libsemanage-dev make bison gettext
        ;;
    *CentOS*)
        sudo yum install -y epel-release zsh
        sudo yum install --enablerepo=epel -y \
             tree vim tig ctags htop \
             kernel-doc wireshark

        sudo chsh `whoami` -s /bin/zsh

        # install latest golang
        wget -O go.tgz "https://go.dev/dl/go1.19.3.linux-amd64.tar.gz"
           sudo tar -C /usr/local -xzf go.tgz && rm go.tgz

        # gh https://github.com/cli/cli/blob/trunk/docs/install_linux.md
        sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo yum -y install gh

        # install ghq
        # git clone https://github.com/x-motemen/ghq ghq/github.com/x-motemen/ghq
        /usr/local/go/bin/go install github.com/x-motemen/ghq@latest

        # fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --bin
        sudo cp ~/.fzf/bin/fzf /usr/local/bin/
        rm -rf ~/.fzf

        # termshark
        # go install github.com/gcla/termshark@latest
        git clone https://github.com/gcla/termshark
        cd termshark
        /usr/local/go/bin/go install ./...
        cd ..
        rm -rf termshark

        # IUSでgitをインストール
        sudo yum remove -y git
        sudo yum -y install \
             https://repo.ius.io/ius-release-el7.rpm \
             https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        sudo yum -y install libsecret pcre2 emacs-filesystem
        sudo yum -y install git --disablerepo=\* --enablerepo=ius

        # emacs, tmux
        sudo yum -y install \
             https://github.com/cafenero/build_own_packages/releases/download/2023-03-16-emacs-rpm/emacs-28.2-2023.03.16.10.59.el7.x86_64.rpm\
             https://github.com/cafenero/build_own_packages/releases/download/2023-03-16-tmux-rpm/tmux-3.3-2023.03.16.10.59.el7.x86_64.rpm\
             mozc
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        ;;
esac

# init emacs
emacs \
    --eval "(defun package-install-selected-packages-no-prompt ()
             \"Install selected packages without prompting for confirmation.\"
             (interactive)
               (let ((package-menu-async nil))
               (cl-letf (((symbol-function 'yes-or-no-p) (lambda (&rest args) t))
               ((symbol-function 'y-or-n-p) (lambda (&rest args) t)))
               (package-install-selected-packages))))"\
    -e 'package-refresh-contents' \
    -e 'package-install-selected-packages-no-prompt'\
    -e 'kill-emacs'
emacsclient -e '(kill-emacs)'
