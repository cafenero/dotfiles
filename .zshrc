# ----------------------------------------------------------------
# general settings
# ----------------------------------------------------------------

# common settings
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit colors vcs_info select-word-style
compinit -i
colors
vcs_info
stty stop undef
select-word-style default

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
zstyle ':completion:*:default' menu select
zstyle ':completion:*' list-separator '-->'
zstyle ':vcs_info:*' formats '(%F{green}%b%f)'
zstyle ':zle:*' word-chars ' -_/=;@:{}[]()<>,.'
zstyle ':zle:*' word-style unspecified
bindkey "^[f" emacs-forward-word

# custom tab for zsh prompt
my_tab_or_complete() {
    if [[ $CURSOR == 0 ]]; then
        zle end-of-line
        zle expand-or-complete
    else
        zle expand-or-complete
    fi
}
zle -N my_tab_or_complete
bindkey '^I' my_tab_or_complete

# setopts
setopt hist_reduce_blanks
setopt hist_expand
setopt brace_ccl
setopt prompt_subst
setopt +o nomatch
setopt inc_append_history
setopt hist_ignore_dups

# common aliases
alias ked="emacsclient -e '(kill-emacs)'"
alias E="emacs --daemon"
alias EE="emacs -nw"
alias e='my_e'
alias tm='tmux'
alias tma='tmux a'
alias mt='tmux'
alias sc='screen'
alias wa='watch -c -n 1 -d '
alias termshark='my_termshark'
alias iftop="my_iftop $@"
alias vm='my_vm'
alias pu='pushd'
alias po='popd'
alias gs='git status'
alias gd='git diff --color'
alias gl='git log --graph --stat'
alias glg='git log --grep'
alias ga='git add'
alias gcv='git commit -v'
alias gcb='my_gcb'
alias gdd="gd | delta"
alias grv="git remote -v"
alias gp="git pull"
alias gr="git remote -v"
alias gpoa="git push origin @"
alias git="my_git"
alias gg='ghq get -l'
alias vs="sudo ovs-vsctl"
alias of="sudo ovs-ofctl"
alias s='send.sh'
alias d="docker"
alias dc="docker compose"
alias watch="watch --color"
alias tree='tree -C -a -I .git'
alias rp='realpath'
alias rph='hostname | tr -d "\n" ; echo -n : ; realpath'
alias mssh='my_mssh'
alias Group_docker="my_group_docker"
alias pwdd='my_pwdd'
alias cdg='my_cdg'
alias g='my_fzf_ghq'
alias imgcat='my_imgcat_for_tmux'
alias ff='my_ff'
alias fzg='my_fzg'
if type kubectl > /dev/null 2>&1 ; then
    alias     k="/usr/bin/sudo kubectl"
    alias    kg="/usr/bin/sudo kubectl get"
    alias  kgpo="/usr/bin/sudo kubectl get pod"
    alias kgpoa="/usr/bin/sudo kubectl get pod --all-namespaces"
    source <(kubectl completion zsh)
fi
MY_GREP_OPTIONS="--color=auto --binary-files=without-match"
alias grep="grep $MY_GREP_OPTIONS"
alias egrep="egrep $MY_GREP_OPTIONS"
alias fgrep="fgrep $MY_GREP_OPTIONS"
alias ggrep="ggrep $MY_GREP_OPTIONS"

# tweek aliases
alias P4i='xvfb-run p4i -w $SDE/build'
alias Tar="my_Tar"
alias Zip="my_Zip"
alias Jq='my_jq'
alias Mkdir='my_mkdir'
alias Gh_pr_merge="gh pr merge -m -d"
alias Gh_pr_rebase="gh pr merge -r -d"
alias Gh_pr_squash="gh pr merge -s -d"
alias Gh_pr_create=" gh pr create -f"

# misc aliases
alias wake="wakeonlan fc:aa:14:29:a6:9"     # xeon01
alias wake_01="wakeonlan 00:3e:e1:cb:b3:3c" # MP
alias wake_02="wakeonlan 60:f4:45:ea:90:3e" # MP WiFi

# common exports
export WORDCHARS='*?_[]~-=&;!#$%^(){}<>|'
export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-R"
export PATH=$PATH:${HOME}/bin

# specific exports
export FZF_DEFAULT_OPTS='
--bind=ctrl-j:accept
--bind=ctrl-w:backward-kill-word
--bind=ctrl-i:toggle-preview
--bind=alt-v:page-up
--bind=ctrl-v:page-down
--bind=ctrl-k:kill-line
--color=bg:#000000,hl:#ff00ff
--color=fg+:#333333,bg+:#eeeeee,hl+:#f57900
--color=info:#afaf87,prompt:#d7005f,pointer:#cc0000
--color=marker:#ef2929,spinner:#af5fff,header:#729fcf
--no-mouse'

MY_zsh_syntax_highlighting=${HOME}/ghq/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -f $MY_zsh_syntax_highlighting ]]; then
    source "$MY_zsh_syntax_highlighting"
fi

# use jump command
if jump > /dev/null 2> /dev/null
then
    eval "$(jump shell --bind=z)" > /dev/null
fi

# alias functions
function my_vm() {
    mv $2 $1
}

function my_gcb() {
    if [ $# -eq 0 ]; then
        git checkout -b "$(date '+%Y-%m-%d-%H-%M')"
    else
        git checkout -b "${1}"
    fi
}

function gw() {
    case ${OSTYPE} in
        darwin*)
            gh browse "$1"
            ;;
        linux*)
            gh browse  -n "$1"
            ;;
    esac
}

function gw_old() {
	if [ $# -eq 0 ]; then
		_PATH=$(realpath .)
	else
		_PATH=$(realpath "$1")
	fi
    URL=https://
    URL=${URL}$(echo ${_PATH} | cut -d '/' -f5)/
    URL=${URL}$(echo ${_PATH} | cut -d '/' -f6)/
    URL=${URL}$(echo ${_PATH} | cut -d '/' -f7)
    URL=${URL}/blob/master/
    URL=${URL}$(echo ${_PATH} | cut -d '/' -f8-)
    # レポジトリのrootだったら、blob/masterは付けない。
    if echo "${URL}" | grep -e "master/$" > /dev/null;
    then
        URL=$(echo "${URL}" | cut -d '/' -f-5)
    fi
    echo "${URL}"
    open "${URL}"
}

function my_cdg() {
    ghq_root=$(ghq root)/$(ghq list "$(grv | grep push | awk '{print $2}' | awk -F@ '{print $2}' | sed -e 's/.git//')")
    cd "$ghq_root" || return
}

# Ref: https://girigiribauer.com/tech/20170208/
function d() {
    zle -U "$(date "+%Y-%m-%d-%H-%M")"
}
zle -N d
bindkey "^Xd" d

function my_mssh() {
    if [[ -e "$1" ]]; then
        my__mssh $(cat "$1")
    else
        my__mssh "$@"
    fi
}

function my__mssh() {
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

function my_Tar() {
    tar zcvf "${1}.tar.gz" "${1}"
}

function my_Zip() {
    zip -r "${1}.zip" "${1}"
}

function my_fzf_ghq() {
    FZF_GHQ_CURRENT_PATH=$(pwd)
    if type bat > /dev/null 2>&1 ; then
        # FZF_GHQ_PATH=$(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80  $(ghq root)/{}/README.*" )
        FZF_GHQ_PATH=$(ghq list | fzf --query "$1" --preview "bat --color=always --style=header,grid --line-range :80  $(ghq root)/{}/README.*" )
    else
        # FZF_GHQ_PATH=$(ghq root)/$(ghq list | fzf --preview "cat  $(ghq root)/{}/README.*" )
        FZF_GHQ_PATH=$(ghq list | fzf --query "$1" --preview "cat  $(ghq root)/{}/README.*" )
    fi
    if [[ -n $FZF_GHQ_PATH ]]; then
        # echo "change path"
        cd "$(ghq root)/$FZF_GHQ_PATH" || return
    else
        # echo "keep path"
        cd "$FZF_GHQ_CURRENT_PATH" > /dev/null || return
    fi
}

function my_e() {
    args=$(echo "$1" | sed -E "s/([^:]+):([0-9:]+)/+\2 \1/g")
    eval emacsclient -nw -a \"\" "$args"
}

function my_group_docker() {
    # adding me to docker group if not in the group
    set -x
    sudo gpasswd -a "$(whoami)" docker
    sudo systemctl restart docker
    newgrp docker
    set +x
}

function my_termshark() {
    (export LC_CTYPE=en_US.UTF-8 ; "${HOME}"/go/bin/termshark "$@")
}

function my_iftop() {
    (export LANG=""; export LC_ALL=""; sudo iftop "$@")
}

function my_imgcat_for_tmux() {
    imgcat "$1"
    # read enter -> clear & re-draw tmux panes
    read -r && tmux split-window resize-pane  && tmux split-window resize-pane
}

# Ref: https://qiita.com/sho-t/items/dca82d5e27b16da12318
function my_ff() {
    if [[ ! -f ~/.MY_FZF_FF_query.txt ]]; then
        touch ~/.MY_FZF_FF_query.txt
    fi
    if FF_PATH=$(my__ff $1);
    then
        echo " e $FF_PATH"
        e "$FF_PATH"
        print -S "e $FF_PATH"
    fi
}

function my__ff() {
    FILE_NAME=~/.MY_FZF_FF_query.txt
    INITIAL_QUERY=$(cat $FILE_NAME)
    if [[ -n $1 ]]; then
        INITIAL_QUERY=$1
    fi
    ff_cmd="find ./ -type f | grep -v '!' | sed -e 's/\.\/\///g' | grep --color=always -i --binary-files=without-match"
    selected=$(FZF_DEFAULT_COMMAND="$ff_cmd '$INITIAL_QUERY'" \
                                  fzf --bind="change:top+reload($ff_cmd {q} || true ;  echo {q} > ${FILE_NAME})" \
                                  --ansi --phony \
                                  --query "$INITIAL_QUERY" \
                                  --delimiter=":" \
                                  --preview="cat {1}" )
    local ret=$?
    [[ -n "$selected" ]] && echo "$selected"
    return $ret
}

function my_fzg() {
    if [[ ! -f ~/.MY_FZF_FZG_query.txt ]]; then
        touch ~/.MY_FZF_FZG_query.txt
    fi
    if result=$(my__fzg $1);
    then
        echo " e $result"
        e "$result"
        print -S "e $result"
    fi
}

function my__fzg() {
    FILE_NAME=~/.MY_FZF_FZG_query.txt
    INITIAL_QUERY=$(cat $FILE_NAME)
    if [[ -n $1 ]]; then
        INITIAL_QUERY=$1
    fi
    # emulate -L zsh
    fzg_cmd="GREP_COLORS='mt=01;31:fn=:ln=:bn=:se=:ml=:cx=:ne' grep -r --line-number --color=always --binary-files=without-match --exclude='*!*' --exclude='TAGS' "
    selected=$(FZF_DEFAULT_COMMAND="$fzg_cmd '$INITIAL_QUERY' | sed -e 's/^\.\///g' " \
                                  fzf --bind="change:top+reload($fzg_cmd {q} | sed -e 's/\.\///g' || true ;  echo {q} > ${FILE_NAME})" \
                                  --ansi --phony \
                                  --query "$INITIAL_QUERY" \
                                  --delimiter=":" \
                                  --preview="GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36' grep --color=always -n {q} {1} -C 20 | grep --color=always {2} -C 10" )
    # --preview="GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36' grep --color=always -n {q} {1} -C 20 | grep --color=always ^{2} -C 10" ) # NG in some env.

    local ret=$?
    if [[ -n "$selected" ]]; then
        echo "${${(@s/:/)selected}[1]}:${${(@s/:/)selected}[2]}"
    fi
    return $ret
}

function my_jq() {
    cat "$1" | jq
}

function my_mkdir() {
    mkdir $1 && cd $1
}

my_git() {
    if [[ "$1" == "sw" || "$1" == "swi" ]]; then
        # echo "no args to -"
        command git switch -
    elif [[ "$1" == "switch" && "$2" == "" ]]; then
        # echo "mod default behavior"
        command git switch -
    else
        # echo "pass through"
        command git "$@"
    fi
}


# ----------------------------------------------------------------
# prompt settings
# ----------------------------------------------------------------
P_MARK="%(?,%F{white},%F{red})%(!,#,$)%f"
PURPLE=$'%{\e[1;35m%}'
RED=$'%{\e[38;5;88m%}'
ENDC=$'%{\e[m%}'

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
    echo "$1" | sed -e 's/\(\/.\)[^\/]*/\1/g'
}

function MyPwdLastDir() {
    if [[ ! "$1" == "/" ]]; then
        echo "$1" | sed -e 's/.*\///g'
    fi

}

function MyPwdWithoutLastDir() {
    _ret=$(echo "$1" | sed -e 's/\(\/.\)[^\/]*/\1/g')
    echo "${_ret:0:-1}"
}

function precmd() {
    vcs_info
    if [ ${MY_OPTION_SHORTEN_PATH} -eq 0 ]; then
        MYPWD=$(MyPwdShorten "$(print -P "%~")")
    elif [ ${MY_OPTION_SHORTEN_PATH} -eq 1 ]; then
        MYPWD=$(MyPwdWithoutLastDir "$(print -P "%~")")$(MyPwdLastDir "$(print -P "%~")")
    else
        MYPWD=$(print -P "%~")
    fi
    PROMPT="%{${fg[cyan]}%}(%*)%{${reset_color}%} ${PURPLE}${HOST}${ENDC}:${MYPWD}/ ${P_MARK} ${vcs_info_msg_0_}
 "
}

function my_pwdd() { ls -d "$PWD/$1"; }

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


# ----------------------------------------------------------------
# misc settings
# ----------------------------------------------------------------

function copilot-mode-enable() {
    echo 1 > ~/.MY_EMACS_ENABLE_COPILOT.txt
    cat ~/.MY_EMACS_ENABLE_COPILOT.txt
}
function copilot-mode-disable() {
    echo 0 > ~/.MY_EMACS_ENABLE_COPILOT.txt
    cat ~/.MY_EMACS_ENABLE_COPILOT.txt
}

function cop() {
    if [[ -n $1 ]]; then
        copilot-mode-disable
    else
        copilot-mode-enable
    fi
}

function co() {
    cop $1
}


# ----------------------------------------------------------------
# OS specific settings
# ----------------------------------------------------------------
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
        if [ -f ~/API_tokens/token_brew_api ]; then
            source ~/API_tokens/token_brew_api
        fi

        # digital ocean api token
        if [ -f ~/API_tokens/token_digital_ocean ]; then
            source ~/API_tokens/token_digital_ocean
        fi
        # digital ocean api token
        if [ -f ~/API_tokens/token_dockerhub ]; then
            source ~/API_tokens/token_dockerhub
        fi

        function cd(){
            builtin cd "$@" && gls -l --color && pwd;
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

        # one time only
        # https://qiita.com/seteen/items/5698089808612f6b87e0
        # defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
        # defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
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
            cd /usr/share/doc/git/contrib/diff-highlight/ || return
            sudo make
        fi

        PATH_TMP=$(find /usr/share/doc/git* -type d | grep diff-highlight | xargs echo | sed -e 's/ /:/g')
        export PATH=$PATH:$PATH_TMP
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
        export SDE=$HOME/bf-sde-0.0.0

        # P4 dev
        if [ -f ~/tools/set_sde.bash ]; then
            source ~/tools/set_sde.bash
            alias sdes="cd ${SDE}/pkgsrc/switch-p4-16/p4src"
        fi
        if [ -e ~/tools ]; then
            export PATH=$PATH:$HOME/tools
        fi
        if [ -e "$SDE" ]; then
            export PATH=$PATH:$SDE
        fi

        function cd(){
            builtin cd "$@" && ls -l --color && pwd;
        }

        # unix domain socket settings for screen/tmux
        agent="$HOME/.ssh-agent-$(hostname)"
        if [ "$(uname)" = Linux ]; then
            if [ -S "$agent" ]; then
                export SSH_AUTH_SOCK="$agent"
            elif [ ! -S "$SSH_AUTH_SOCK" ]; then
                export SSH_AUTH_SOCK="$agent"
            elif [ ! -L "$SSH_AUTH_SOCK" ]; then
                ln -snf "$SSH_AUTH_SOCK" "$agent" && export SSH_AUTH_SOCK="$agent"
            fi
        fi
        ;;
esac

if [ -f ~/.office.zshrc ]; then
    source ~/.office.zshrc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
