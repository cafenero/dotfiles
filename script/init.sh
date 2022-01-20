#!/bin/bash

################################
# For Ubuntu 18.04 raspi/jetson
################################
 curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
 echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
 sudo apt update
 sudo apt install gh

 ghq get go1.17.6.linux-arm64.tar.gz
 go install github.com/x-motemen/ghq@latest

 git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
 ~/.fzf/install

 sudo add-apt-repository ppa:kelleyk/emacs
 sudo apt update
 sudo apt install emacs27-nox emacs-mozc


 # switchbot and bluetooth setup
 sudo apt install libbluetooth-dev
 pip3 install pybluez
 sudo apt install libboost-python-dev libboost-thread-dev
 pip3 install gattlib
