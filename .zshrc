# load
autoload -Uz compinit colors vcs_info
compinit
colors
vcs_info


# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/Users/yusuke/.zshrc'
#zstyle ':completion:*:processes' menu yes select=2
zstyle ':completion:*:default' menu select
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' list-separator '-->'

# setopts
setopt share_history
setopt hist_reduce_blanks
setopt hist_expand
setopt brace_ccl
setopt prompt_subst


#alias -s pdf=PDFNut

# env specifics
case ${OSTYPE} in
    darwin*)
	alias ls='ls -G'
        alias ll='ls -lG'
        alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
        alias sc='/usr/local/Cellar/screen/4.3.0/bin/screen'
        export LC_CTYPE='ja_JP.UTF-8'
	
	# brew api token
        if [ -f ~/.brew_api_token ];then
            source ~/.brew_api_token
        fi

        # digital ocean api token
        if [ -f ~/.digital_ocean_token ];then
            source ~/.digital_ocean_token
        fi
    ;;
    linux*)
	alias ls='ls --color'
	alias ll='ls -l --color'
	alias sc='screen'
	alias df='df -T'
	alias top='top -c'
	alias sys='cd /etc/sysconfig/network-scripts'

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
	;;
esac


#local P_INFO="%(!,#,$)"
#local P_MARK="%(?,%F{white},%F{red})%(!,#,%B$%b)%f"
local P_MARK="%(?,%F{white},%F{red})%(!,#,$)%f"
#local P_MARK="%(!,#,$)"
local PURPLE=$'%{\e[1;35m%}'
local RED=$'%{\e[38;5;88m%}'
local ENDC=$'%{\e[m%}'
PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} %n@${PURPLE}${HOST}${ENDC}:%~] ${P_MARK}
 "

# git prompt
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
precmd() { vcs_info }
#RPROMPT='[${vcs_info_msg_0_}]:%~/%f '


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
# source ~/.git-prompt.sh
# source ~/.git-completion.bash
# export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWUNTRACKEDFILES=true
# export GIT_PS1_SHOWSTASHSTATE=true
# export GIT_PS1_SHOWUPSTREAM=auto
#PS1='\033[1;34m\](\t) \[\033[0m\]\u@\[\033[1;34m\]\H\[\033[0m\]:\w]$(__git_ps1 " (%s)")\n '



# git
alias gs='git status'
alias gd='git diff'
alias gl='git log --graph'


#export WORDCHARS='*?_[]~-=&;!#$%^(){}<>'
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>|'

function cd(){
    builtin cd $@ && ls -l;
    }

