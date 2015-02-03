# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ll='ls -l'
alias sc='screen'
#alias sc='$HOME/local/bin/screen-4.2.1'
alias e='emacs'
alias pu='pushd'
alias po='popd'

export PATH=$PATH:/usr/local/sbin/

export PS1="\[\033[1;34m\](\t) \[\033[0m\]\u@\[\033[1;34m\]\H\[\033[0m\]:\w ]\n\\$ "
export LSCOLORS=gxfxcxdxbxegedabagacad

if [ `uname`  = Linux ]; then
	alias ls='ls --color'
	alias ll='ls -l --color'
fi

