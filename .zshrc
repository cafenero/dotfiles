fpath=(~/.zsh/completion $fpath)
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

bindkey "^[f" emacs-forward-word

# setopts
setopt share_history
setopt hist_reduce_blanks
setopt hist_expand
setopt brace_ccl
setopt prompt_subst


# funcitons
function mssh() {
#tmux new-window "exec ssh $1"
tmux new-window "exec zsh"
shift
for host in "$@"; do
  tmux split-window "exec zsh"
#  tmux select-layout even-vertical > /dev/null
  tmux select-layout even-horizontal > /dev/null
#  tmux select-layout tiled > /dev/null
done
tmux set-window-option synchronize-panes on
tmux select-layout tiled > /dev/null
#tmux select-layout even-vertical > /dev/null
#tmux select-layout even-horizontal > /dev/null
}

function cd(){
    builtin cd $@ && ls -l;
    }




#alias -s pdf=PDFNut

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
        export LC_CTYPE='ja_JP.UTF-8'
#	export PATH=$PATH:/usr/local/Cellar/git/2.18.0//share/git-core/contrib/diff-highlight
	export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

## debug	
	##	export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
## debug(add)
#	export PATH=$PATH:/usr/local/sbin
#	export PATH="/usr/local/sbin:$PATH"
	export PATH=$PATH:/Users/yusuke/.nodebrew/current/bin
	export HOMEBREW_CASK_OPTS="--appdir=/Applications"


	export ANDROID_HOME=$HOME/Library/Android/sdk
	export PATH=$PATH:$ANDROID_HOME/tools
	export PATH=$PATH:$ANDROID_HOME/platform-tools
	
	# brew api token
        if [ -f ~/.brew_api_token ];then
            source ~/tokens/.brew_api_token
        fi

        # digital ocean api token
        if [ -f ~/.digital_ocean_token ];then
            source ~/tokens/.digital_ocean_token
        fi
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
#PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} %n@${PURPLE}${HOST}${ENDC}:%~] ${P_MARK}
PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} %n@${PURPLE}${HOST}${ENDC}:%~/ ${P_MARK} "'${vcs_info_msg_0_}'"
 "

# git prompt
#zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
#zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'

zstyle ':vcs_info:*' formats '(%F{green}%b%f)'

precmd() { vcs_info }
#RPROMPT='[${vcs_info_msg_0_}]:%~/%f '


# aliases & CLI options
alias e='emacs'
alias pu='pushd'
alias po='popd'
# alias diff='colordiff -u'

MY_GREP_OPTIONS="--color=auto --binary-files=without-match"
alias grep="grep $MY_GREP_OPTIONS"
alias egrep="egrep $MY_GREP_OPTIONS"
alias fgrep="fgrep $MY_GREP_OPTIONS"

export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-R"


# path settings
#export PATH=$PATH:/usr/local/sbin:/bin:/usr/texbin
#export PATH=$PATH:/usr/sbin
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
#alias gd='git diff --word-diff-regex="\w+" $@'
alias gl='git log --graph'


#export WORDCHARS='*?_[]~-=&;!#$%^(){}<>'
#export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>|'
export WORDCHARS='*?_[]~-=&;!#$%^(){}<>|'


# export RTE_SDK=/home/yusuke/dpdk-2.2.0
# export RTE_TARGET=x86_64-native-linuxapp-gcc

# export DISPLAY=:0.0


# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


## uncomment for using pyenv
# for pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"


## Set path for pyenv
# export PYENV_ROOT="${HOME}/.pyenv"
# if [ -d "${PYENV_ROOT}" ]; then
#     export PATH=${PYENV_ROOT}/bin:$PATH
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
# fi



