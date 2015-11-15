# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# env specific
if [ `uname`  = Darwin ]; then
    alias ls='ls -G'
    alias ll='ls -lG'
    alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
    alias sc='/usr/local/Cellar/screen/4.3.0/bin/screen'
    export LC_CTYPE='ja_JP.UTF-8'

    # brew api token
    if [ -f ~/.brew_api_token ];then
	source ~/.brew_api_token
    fi
fi
if [ `uname`  = Linux ]; then
    alias ls='ls --color'
    alias ll='ls -l --color'
    alias sc='screen'
    # unix domain socket settings for screen
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
fi


# aliases & CLI options
alias e='emacs'
alias pu='pushd'
alias po='popd'
alias diff='colordiff -u'

MY_GREP_OPTIONS="--color=auto --binary-files=without-match"
alias grep="grep $MY_GREP_OPTIONS"
alias egrep="egrep $MY_GREP_OPTIONS"
alias fgrep="fgrep $MY_GREP_OPTIONS"

export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-R"


# path settings
export PATH=$PATH:/usr/local/sbin:/bin:/usr/texbin
export GOPATH=${HOME}/.go


# PS1 settings, with git
source ~/.git-prompt.sh
source ~/.git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM=auto
PS1='\033[1;34m\](\t) \[\033[0m\]\u@\[\033[1;34m\]\H\[\033[0m\]:\w]$(__git_ps1 " (%s)")\n '

