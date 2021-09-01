fpath=(~/.zsh/completion $fpath)

# load
autoload -Uz compinit colors vcs_info
compinit
colors
vcs_info

stty stop undef

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
zstyle ':completion:*:default' menu select
zstyle ':completion:*' list-separator '-->'
zstyle ':vcs_info:*' formats '(%F{green}%b%f)'



autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' -_/=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified


# bindkey "^[f" emacs-forward-word

# setopts
setopt share_history
setopt hist_reduce_blanks
setopt hist_expand
setopt brace_ccl
setopt prompt_subst
precmd() { vcs_info }


# common alias
alias ked="emacsclient -e '(kill-emacs)'"
alias E="emacs --daemon"
alias e='emacsclient -t -a ""'
alias wa='watch -c -n 1 -d '
alias termshark='export LC_CTYPE=en_US.UTF-8 ; ${HOME}/go/bin/termshark'
alias pu='pushd'
alias po='popd'
alias gs='git status'
alias gd='git diff --color'
alias gl='git log --graph'
alias pwdd='_pwdd'
alias s='send.sh'
alias d="docker"

if type kubectl > /dev/null 2>&1 ; then
	alias k="kubectl"
	alias kg="kubectl get"
	alias kgpo="kubectl get pod"
	alias kgpoa="kubectl get pod --all-namespaces"
	source <(kubectl completion zsh)
fi
alias vs="sudo ovs-vsctl"
alias of="sudo ovs-ofctl"

MY_GREP_OPTIONS="--color=auto --binary-files=without-match"
alias grep="grep $MY_GREP_OPTIONS"
alias egrep="egrep $MY_GREP_OPTIONS"
alias fgrep="fgrep $MY_GREP_OPTIONS"
alias gdd="gd | delta"
alias pwdd='_pwdd'
alias rp='realpath'
alias mssh='_mssh'

# common export
export WORDCHARS='*?_[]~-=&;!#$%^(){}<>|'
export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-R"
export PATH=$PATH:${HOME}/bin

# use jump command
output=$(jump)
if [ $? -ne 0 ]; then
	eval "$(jump shell --bind=z)"
fi

## prompt
local P_MARK="%(?,%F{white},%F{red})%(!,#,$)%f"
local PURPLE=$'%{\e[1;35m%}'
local RED=$'%{\e[38;5;88m%}'
local ENDC=$'%{\e[m%}'
PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} ${PURPLE}${HOST}${ENDC}:%~/ ${P_MARK} "'${vcs_info_msg_0_}'"
 "


function _pwdd() { ls -d $PWD/$1; }

function set_tmux_bgcolor_bg_white() {
	tmux select-pane -P 'bg=white,fg=black'
}
function set_tmux_bgcolor_default() {
	tmux select-pane -P 'default'
}

function set_iterm_bgcolor(){
  local R=$1
  local G=$2
  local B=$3
  /usr/bin/osascript <<EOF
	tell application "iTerm"
	  tell current session of current window
	      set background color to {$(echo "scale=2; ($1/255.0)*65535" | bc),$(echo "scale=2; ($2/255.0)*65535" | bc),$(echo "scale=2; ($3/255.0)*65535" | bc)}
	  end tell
	end tell
EOF
}
function set_ibgcolor_black(){
	set_term_bgcolor 0 0 0
}

function _mssh() {
	if [ -e $1 ]; then
		__mssh `cat $1`
	else
		__mssh  $*
	fi
}
function __mssh() {
	COUNT=0
	tmux new-window "exec ssh $1"
	shift
	for host in "$@"; do
		tmux split-window -h "exec ssh $1"
		tmux resize-pane -L 100 > /dev/null
		(( COUNT ++ ))
		if [ $(( $COUNT % 5 )) -eq 0 ]; then
			tmux select-layout tiled > /dev/null
		fi
	done
	tmux set-window-option synchronize-panes on
	tmux select-layout tiled > /dev/null
	#tmux select-layout even-vertical > /dev/null
	#tmux select-layout even-horizontal > /dev/null
}


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
        alias python=/usr/local/bin/../Cellar/python@3.8/3.8.6_2/bin/python3
        alias pip=/usr/local/bin/../Cellar/python@3.8/3.8.6_2/bin/pip3

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
        if [ -f ~/tokens/token_brew_api ];then
            source ~/tokens/token_brew_api
        fi

        # digital ocean api token
        if [ -f ~/API_tokens/token_digital_ocean ];then
            source ~/API_tokens/token_digital_ocean
        fi
        # digital ocean api token
        if [ -f ~/API_tokens/token_dockerhub ];then
            source ~/API_tokens/token_dockerhub
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

        export PATH=$PATH:/usr/share/doc/git/contrib/diff-highlight
        # export LC_ALL=C.UTF-8
        export LC_ALL=en_US.UTF-8

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
