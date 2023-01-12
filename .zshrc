fpath=(~/.zsh/completion $fpath)

# load
autoload -Uz compinit colors vcs_info
compinit -i
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
zstyle ':zle:*' word-chars ' _/=;@:{}[]()<>,.'
zstyle ':zle:*' word-style unspecified

bindkey "^[f" emacs-forward-word

# setopts
setopt share_history
setopt hist_reduce_blanks
setopt hist_expand
setopt brace_ccl
setopt prompt_subst
setopt +o nomatch
# precmd() { vcs_info }


# common alias
alias ked="emacsclient -e '(kill-emacs)'"
alias E="emacs --daemon"
alias EE="emacs -nw"
# alias e='emacsclient -t -a ""'
alias e='_e'
alias tm='tmux'
alias tma='tmux a'
alias mt='tmux'
alias sc='screen'
alias wa='watch -c -n 1 -d '
alias termshark='_termshark'
alias iftop="_iftop $@"
alias pu='pushd'
alias po='popd'
alias gs='git status'
alias gd='git diff --color'
alias gl='git log --graph --stat'
alias ga='git add'
alias gcv='git commit -v'
alias pwdd='_pwdd'
alias s='send.sh'
alias d="docker"
alias Group_docker="_group_docker"
alias grv="git remote -v"
alias watch="watch --color"

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
alias gp="git pull"
alias gr="git remote -v"

# tweek aliases
alias P4i='xvfb-run p4i -w $SDE/build'
alias Tar="_Tar"
alias Zip="_Zip"
alias Gh_pr_merge="gh pr merge -m -d"
alias Gh_pr_create=" gh pr create -f"
alias g='_fzf_ghq'
alias gg='ghq get -l'

alias wake="wakeonlan fc:aa:14:29:a6:9"     # xeon01
alias wake_01="wakeonlan 00:3e:e1:cb:b3:3c" # MP
alias wake_02="wakeonlan 60:f4:45:ea:90:3e" # MP WiFi


# common export
export WORDCHARS='*?_[]~-=&;!#$%^(){}<>|'
export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-R"
export PATH=$PATH:${HOME}/bin

# use jump command
output=$(jump 2> /dev/null)
if [ $? -eq 0 ]; then
	eval "$(jump shell --bind=z)"
fi


function gw() {
    gh browse $1
}


# https://girigiribauer.com/tech/20170208/
# function print_date() {
function d() {
  # zle -U `date "+%Y-%m-%d"`
  zle -U `date "+%Y-%m-%d-%H-%M"`
}
zle -N d
bindkey "^Xd" d


# ----------------------------------------------------------------
## prompt
# ----------------------------------------------------------------
local P_MARK="%(?,%F{white},%F{red})%(!,#,$)%f"
local PURPLE=$'%{\e[1;35m%}'
local RED=$'%{\e[38;5;88m%}'
local ENDC=$'%{\e[m%}'

export MY_OPTION_SHORTEN_PATH=1
function short() {
	sho
}
function sho() {
    export MY_OPTION_SHORTEN_PATH=0
}
function middle() {
	mi
}
function mi() {
    export MY_OPTION_SHORTEN_PATH=1
}
function long() {
	lo
}
function lo() {
    export MY_OPTION_SHORTEN_PATH=2
}

function MyPwdShorten() {
	echo $1 | sed -e 's/\(\/.\)[^\/]*/\1/g'
}
function MyPwdLastDir() {
	if [[ "$1" == "/" ]]; then
		# do nothing
	else
		echo $1 | sed -e 's/.*\///g'
	fi

}
function MyPwdWithoutLastDir() {
	_ret=$(echo $1 | sed -e 's/\(\/.\)[^\/]*/\1/g')
	echo ${_ret:0:-1}
}

function precmd() {
	vcs_info
	if [ ${MY_OPTION_SHORTEN_PATH} -eq 0 ]; then
		MYPWD=$(MyPwdShorten `print -P "%~"`)
	elif [ ${MY_OPTION_SHORTEN_PATH} -eq 1 ]; then
		MYPWD=$(MyPwdWithoutLastDir `print -P "%~"`)$(MyPwdLastDir `print -P "%~"`)
	else
		MYPWD=$(print -P "%~")
    fi
		PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} ${PURPLE}${HOST}${ENDC}:${MYPWD}/ ${P_MARK} ${vcs_info_msg_0_}
 "
}

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
		# tmux split-window -h "exec ssh $1"
		tmux split-window -h "exec ssh $host"
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
function _Tar() {
    tar zcvf ${1}.tar.gz ${1}
}

function _Zip() {
    zip -r ${1}.zip ${1}
}

function _fzf_ghq() {
    FZF_GHQ_CURRENT_PATH=`pwd`

    if type bat > /dev/null 2>&1 ; then
        FZF_GHQ_PATH=$(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80  $(ghq root)/{}/README.*" )
    else
        FZF_GHQ_PATH=$(ghq root)/$(ghq list | fzf --preview "cat  $(ghq root)/{}/README.*" )
        # FZF_GHQ_PATH=$(ghq get --look `ghq list |fzf --preview "cat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*`)
    fi

    if [ $? == 0 ]; then
        # echo "change path"
        cd $FZF_GHQ_PATH
    else
        # echo "keep path"
        cd $FZF_GHQ_CURRENT_PATH > /dev/null
    fi
}

function _e() {
    args=`echo $1 | sed -E "s/([^:]+):([0-9:]+)/+\2 \1/g"`
    eval emacsclient -nw -a \"\" $args
}


function _group_docker() {
    # adding me to docker group if not in the group
    set -x
    sudo gpasswd -a `whoami` docker
    sudo systemctl restart docker
    newgrp docker
    set +x
}

function _termshark() {
    (export LC_CTYPE=en_US.UTF-8 ; ${HOME}/go/bin/termshark $@)
}

function _iftop() {
    (export LANG=""; export LC_ALL=""; sudo iftop $@)
}

function _imgcat_for_tmux() {
    imgcat "$1"
    # read enter -> clear & re-draw tmux panes
    read && tmux split-window resize-pane  && tmux split-window resize-pane
}
alias imgcat='_imgcat_for_tmux'

case ${OSTYPE} in
    darwin*)
        alias ls='gls --color'
        alias ll='gls -l --color'
        alias l='ll'
        export LC_CTYPE='ja_JP.UTF-8'
        export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
        export PATH=$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight
        export PATH=$PATH:${HOME}/.go/bin:${HOME}/go/bin
        export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

        ## disable for pyenv
        alias python=python3
        alias pip=pip3

        ## debug
        ## export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
        ## debug(add)
        ## export PATH=$PATH:/usr/local/sbin
        export PATH=$PATH:/Users/$USER/.nodebrew/current/bin
        export HOMEBREW_CASK_OPTS="--appdir=/Applications"


        export ANDROID_HOME=$HOME/Library/Android/sdk
        export PATH=$PATH:$ANDROID_HOME/tools
        export PATH=$PATH:$ANDROID_HOME/platform-tools

        # for golang
        export GOPATH=$HOME/go
		export GO111MODULE=on

		# for X11
		export DISPLAY=:0

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
            builtin cd $@ && gls -l --color && pwd;
        }

        # needed at END line ?
        export PATH="/usr/local/sbin:$PATH"

        # one time only
        # https://mmazzarolo.com/blog/2022-04-16-drag-window-by-clicking-anywhere-on-macos/
        # defaults write -g NSWindowShouldDragOnGesture -bool true

        # one time only
        # defaults write com.apple.screencapture location /Users/$USER/Desktop/screen_shot/zzz
        # mkdir -p screen_shot/zzz
        # killall SystemUIServer

        ;;
    linux*)
        alias ls='ls --color'
        alias ll='ls -l --color'
        alias l='ll'
        alias df='df -T'
        alias top='top -c'
        alias vmstat='vmstat -w'
        alias sys='cd /etc/sysconfig/network-scripts'

        alias sudo='sudo -E '
        # alias sudo='sudo '


        # https://superuser.com/questions/523564/emacs-keybindings-in-zsh-not-working-ctrl-a-ctrl-e
        bindkey -e
        bindkey "^[f" emacs-forward-word

        export EDITOR=vim

        export PATH=$PATH:/usr/share/doc/git/contrib/diff-highlight
        export PATH=$PATH:/usr/share/doc/git/contrib/diff-highlight/diff-highlight
        TMP_PATH_GIT_DIFF_HIGHLIGHT=/usr/share/doc/git/contrib/diff-highlight/diff-highlight
        if [[ -e "${TMP_PATH_GIT_DIFF_HIGHLIGHT}" ]] && [[ ! -x "${TMP_PATH_GIT_DIFF_HIGHLIGHT}" ]]; then
            echo sudo chmod 755 $TMP_PATH_GIT_DIFF_HIGHLIGHT
            sudo chmod 755 $TMP_PATH_GIT_DIFF_HIGHLIGHT
        fi
        # if "make" necessary
        if [[ ! -e "${TMP_PATH_GIT_DIFF_HIGHLIGHT}" ]] && [[ -e "/usr/share/doc/git/contrib/diff-highlight/Makefile" ]]; then
            echo cd /usr/share/doc/git/contrib/diff-highlight/
            echo sudo make
            cd /usr/share/doc/git/contrib/diff-highlight/
            sudo make
        fi

        export PATH=$PATH:`find /usr/share/doc/git* -type d | grep diff-highlight | xargs echo | sed -e 's/ /:/g'`
        # export LC_ALL=C.UTF-8
        export LC_ALL=en_US.UTF-8

        # for golang
        export PATH=$PATH:/usr/local/go/bin
        export GOPATH=$HOME/go
		export GO111MODULE=on



        export PATH=$GOPATH/bin:$PATH

        # for python
        export PATH=$PATH:$HOME/.local/bin

		# for my bin/
		export PATH=$HOME/bin:$PATH

		# for my dev env
		export SDE=/home/ytatsumi/bf-sde-9.8.0

        # P4 dev
        if [ -f ~/tools/set_sde.bash ];then
           source ~/tools/set_sde.bash
           alias sdes="cd ${SDE}/pkgsrc/switch-p4-16/p4src"
        fi
        if [ -e ~/tools ];then
           export PATH=$PATH:$HOME/tools
        fi
        if [ -e $SDE ];then
           export PATH=$PATH:$SDE
        fi

        lesskey

        function cd(){
            builtin cd $@ && ls -l --color && pwd;
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



## fzf
export FZF_DEFAULT_OPTS='--bind=ctrl-j:accept --bind=ctrl-i:accept --bind=ctrl-e:accept --bind=ctrl-k:kill-line --color=bg:#000000,hl:#ff00ff --color=fg+:#333333,bg+:#eeeeee,hl+:#f57900 --color=info:#afaf87,prompt:#d7005f,pointer:#cc0000 --color=marker:#ef2929,spinner:#af5fff,header:#729fcf'
# export FZF_DEFAULT_OPTS='
#   --color fg:124,bg:16,hl:202,fg+:214,bg+:52,hl+:231
#   --color info:52,prompt:196,spinner:208,pointer:196,marker:208
# '


## gheを開きたいのだが、、
## github.comが開かれてしまう。
# alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'



# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi


MY_zsh_syntax_highlighting=${HOME}/ghq/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -f $MY_zsh_yntax_highlighting ]];then
   source $MY_zsh_syntax_highlighting
fi

if [ -f ~/.office.zshrc ];then
	source ~/.office.zshrc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
