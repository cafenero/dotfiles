# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
if [ `uname`  = Darwin ]; then
    alias ls='ls -G'
    alias ll='ls -lG'
    alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
fi
if [ `uname`  = Linux ]; then
    alias ls='ls --color'
    alias ll='ls -l --color'
fi

alias sc='screen'
#alias sc='$HOME/local/bin/screen-4.2.1'
alias e='emacs'
alias pu='pushd'
alias po='popd'
alias diff='colordiff -u'

export PATH=$PATH:/usr/local/sbin/
export PS1="\[\033[1;34m\](\t) \[\033[0m\]\u@\[\033[1;34m\]\H\[\033[0m\]:\w ]\n "
export LSCOLORS=gxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'
export LESS="-R"
export GOPATH=${HOME}/.go


#############################################
### Linux server only                      ##
### unix domain socket settings for screen ##
#############################################
agent="$HOME/.screen/.ssh-agent-`hostname`"
if [ `uname`  = Linux ]; then
	if [ -S "$agent" ]; then
	    export SSH_AUTH_SOCK=$agent
	elif [ ! -S "$SSH_AUTH_SOCK" ]; then
	    export SSH_AUTH_SOCK=$agent
	elif [ ! -L "$SSH_AUTH_SOCK" ]; then
	    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
	fi
fi
