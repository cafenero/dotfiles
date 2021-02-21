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


precmd() { vcs_info }


alias ked="emacsclient -e '(kill-emacs)'"
alias E="emacs --daemon"
alias e='emacsclient -t -a ""'
alias wa='watch -c -n 1 -d '
alias termshark='export LC_CTYPE= ; ${HOME}/go/bin/termshark'
alias pu='pushd'
alias po='popd'
alias gs='git status'
alias gd='git diff --color'
alias gl='git log --graph'


MY_GREP_OPTIONS="--color=auto --binary-files=without-match"
alias grep="grep $MY_GREP_OPTIONS"
alias egrep="egrep $MY_GREP_OPTIONS"
alias fgrep="fgrep $MY_GREP_OPTIONS"


case ${OSTYPE} in
    darwin*)
		alias ls='gls --color'
		alias ll='gls -l --color'
        alias ctags='/usr/local/bin/ctags'
        alias sc='/usr/local/bin/screen'
        alias tm='/usr/local/bin/tmux'
		alias brew="env PATH=${PATH/\/Users\/yusuke\/\.pyenv\/shims:/} brew"
		alias rsync='/usr/local/bin/rsync'
        export LC_CTYPE='ja_JP.UTF-8'
		export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
		export PATH=$PATH:${HOME}/.go/bin:${HOME}/go/bin


		## disable for pyenv
		# alias python=/usr/local/bin/python3
		# alias pip=/usr/local/bin/pip3
		alias python=/usr/local/bin/../Cellar/python@3.8/3.8.6_2/bin/python3
		alias pip=/usr/local/bin/../Cellar/python@3.8/3.8.6_2/bin/pip3

		function mssh() {
			command xpanes -c 'ssh {}' `cat $1`
		}

		## debug
		## export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
		## debug(add)
		## export PATH=$PATH:/usr/local/sbin
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
			builtin cd $@ && ls -l --color;
		}
		# unix domain socket settings for screen
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

export WORDCHARS='*?_[]~-=&;!#$%^(){}<>|'
export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-R"


local P_MARK="%(?,%F{white},%F{red})%(!,#,$)%f"
#local P_MARK="%(!,#,$)"
local PURPLE=$'%{\e[1;35m%}'
local RED=$'%{\e[38;5;88m%}'
local ENDC=$'%{\e[m%}'

## いつもの
PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} ${PURPLE}${HOST}${ENDC}:%~/ ${P_MARK} "'${vcs_info_msg_0_}'"
 "
