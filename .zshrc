fpath=(~/.zsh/completion $fpath)
# load
autoload -Uz compinit colors vcs_info
compinit
colors
vcs_info

stty stop undef

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/Users/yusuke/.zshrc'
#zstyle ':completion:*:processes' menu yes select=2
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:default' menu select
zstyle ':completion:*' list-separator '-->'
# git prompt
#zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
#zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'

zstyle ':vcs_info:*' formats '(%F{green}%b%f)'


bindkey "^[f" emacs-forward-word

# setopts
setopt share_history
setopt hist_reduce_blanks
setopt hist_expand
setopt brace_ccl
setopt prompt_subst



# # funcitons
# function mssh() {
# #tmux new-window "exec ssh $1"
# tmux new-window "exec zsh"
# shift
# for host in "$@"; do
#   tmux split-window "exec zsh"
# #  tmux select-layout even-vertical > /dev/null
#   tmux select-layout even-horizontal > /dev/null
# #  tmux select-layout tiled > /dev/null
# done
# tmux set-window-option synchronize-panes on
# tmux select-layout tiled > /dev/null
# #tmux select-layout even-vertical > /dev/null
# #tmux select-layout even-horizontal > /dev/null
# }


precmd() { vcs_info }


alias ked="emacsclient -e '(kill-emacs)'"
alias E="emacs --daemon"
#alias e='emacsclient -t'
#alias e='emacsclient -nw -a ""'
alias e='emacsclient -t -a ""'
alias wa='watch -c -n 1 -d '
alias termshark='export LC_CTYPE= ; ${HOME}/go/bin/termshark'

# env specifics
case ${OSTYPE} in
    darwin*)
#	alias ls='ls -G'
#       alias ll='ls -lG'
	alias ls='gls --color'
	alias ll='gls -l --color'
        alias ctags='/usr/local/bin/ctags'
        alias sc='/usr/local/bin/screen'
        alias tm='/usr/local/bin/tmux'
	alias brew="env PATH=${PATH/\/Users\/yusuke\/\.pyenv\/shims:/} brew"
	alias rsync='/usr/local/bin/rsync'
        export LC_CTYPE='ja_JP.UTF-8'
#	export PATH=$PATH:/usr/local/Cellar/git/2.18.0//share/git-core/contrib/diff-highlight
	export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
#	export PATH=$PATH:/usr/local/opt
	export PATH=$PATH:${HOME}/.go/bin:${HOME}/go/bin


## disable for pyenv
#	alias python=/usr/local/bin/python3
#	alias pip=/usr/local/bin/pip3
	alias python=/usr/local/bin/../Cellar/python@3.8/3.8.6_2/bin/python3
	alias pip=/usr/local/bin/../Cellar/python@3.8/3.8.6_2/bin/pip3

	function mssh() {
	    command xpanes -c 'ssh {}' `cat $1`
	}

	## debug

	##	export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
## debug(add)
#	export PATH=$PATH:/usr/local/sbin
	export PATH=$PATH:/Users/yusuke/.nodebrew/current/bin
	export HOMEBREW_CASK_OPTS="--appdir=/Applications"


	export ANDROID_HOME=$HOME/Library/Android/sdk
	export PATH=$PATH:$ANDROID_HOME/tools
	export PATH=$PATH:$ANDROID_HOME/platform-tools

	# for golang
	export GOPATH=$HOME/go


	# brew api token
        if [ -f ~/.brew_api_token ];then
            source ~/tokens/.brew_api_token
        fi

        # digital ocean api token
        if [ -f ~/.digital_ocean_token ];then
            source ~/tokens/.digital_ocean_token
        fi
        # digital ocean api token
        if [ -f ~/tokens/.dockerhub_token ];then
            source ~/tokens/.dockerhub_token
        fi

	function cd(){
	    builtin cd $@ && gls -l --color;
	    #builtin cd $@ && ll;
	}

	# needed at END line ?
	export PATH="/usr/local/sbin:$PATH"
    ;;
    linux*)
	alias ls='ls --color'
	alias ll='ls -l --color'
	alias sc='screen'
	alias tm='tmux'
	alias df='df -T'
	alias top='top -c'
	alias vmstat='vmstat -w'
	alias sys='cd /etc/sysconfig/network-scripts'
	alias sudo='sudo -E '

	export LC_ALL=C.UTF-8

	# for golang
	export PATH=$PATH:/usr/local/go/bin
	export GOPATH=$HOME/go
	export PATH=$GOPATH/bin:$PATH

	function cd(){
	    #builtin cd $@ && gls -l --color;
	    builtin cd $@ && ls -l --color;
	}
	# unix domain socket settings for screen
	#agent="$HOME/.screen/.ssh-agent-`hostname`"
	agent="$HOME/.ssh-agent-`hostname`"
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

# common alias
# aliases & CLI options
#alias e='emacs'
alias pu='pushd'
alias po='popd'
# alias diff='colordiff -u'

MY_GREP_OPTIONS="--color=auto --binary-files=without-match"
alias grep="grep $MY_GREP_OPTIONS"
alias egrep="egrep $MY_GREP_OPTIONS"
alias fgrep="fgrep $MY_GREP_OPTIONS"
alias gs='git status'
alias gd='git diff --color'
alias gl='git log --graph'
#alias gd='git diff --word-diff-regex="\w+" $@'

#export WORDCHARS='*?_[]~-=&;!#$%^(){}<>'
#export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>|'
export WORDCHARS='*?_[]~-=&;!#$%^(){}<>|'

export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-R"

#export GOPATH=${HOME}/go
#export GOPATH=${HOME}/.go,




#local P_INFO="%(!,#,$)"
#local P_MARK="%(?,%F{white},%F{red})%(!,#,%B$%b)%f"
local P_MARK="%(?,%F{white},%F{red})%(!,#,$)%f"
#local P_MARK="%(!,#,$)"
local PURPLE=$'%{\e[1;35m%}'
local RED=$'%{\e[38;5;88m%}'
local ENDC=$'%{\e[m%}'
#PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} %n@${PURPLE}${HOST}${ENDC}:%~] ${P_MARK}

#PROMPT="%{${fg[cyan]}%}()%{${reset_color}%} %n@${PURPLE}${HOST}${ENDC}:%~/ ${P_MARK} "'${vcs_info_msg_0_}'"


## いつもの
#PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} %n@${PURPLE}${HOST}${ENDC}:%~/ ${P_MARK} "'${vcs_info_msg_0_}'"
PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} ${PURPLE}${HOST}${ENDC}:%~/ ${P_MARK} "'${vcs_info_msg_0_}'"
 "



#RPROMPT='[${vcs_info_msg_0_}]:%~/%f '





# path settings
#export PATH=$PATH:/usr/local/sbin:/bin:/usr/texbin
#export PATH=$PATH:/usr/sbin



# PS1 settings, with git
# source ~/.git-prompt.sh
# source ~/.git-completion.bash
# export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWUNTRACKEDFILES=true
# export GIT_PS1_SHOWSTASHSTATE=true
# export GIT_PS1_SHOWUPSTREAM=auto
#PS1='\033[1;34m\](\t) \[\033[0m\]\u@\[\033[1;34m\]\H\[\033[0m\]:\w]$(__git_ps1 " (%s)")\n '





# export RTE_SDK=/home/yusuke/dpdk-2.2.0
# export RTE_TARGET=x86_64-native-linuxapp-gcc

# export DISPLAY=:0.0


# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"



#####
# export PATH="$HOME/.pyenv/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
# export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"





## uncomment for using pyenv
# for pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"


## Set path for pyenv
# export PYENV_ROOT="${HOME}/.pyenv"
# if [ -d "${PYENV_ROOT}" ]; then
#     export PATH=${PYENV_ROOT}/bin:$PATH
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
# fi




# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

#export PATH="/usr/local/sbin:$PATH"
