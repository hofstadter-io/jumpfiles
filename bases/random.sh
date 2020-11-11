HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

function u() {
  N=${1:-1}
  shift 1
  for i in $(seq 1 $N); do cd ..; done

  if [ $# -ne 0 ]; then
    cd $@
  fi
}

alias q="exit"
alias :q="exit"
alias Q="exit"
alias :Q="exit"

alias du1="du --max-depth=1 -h "
alias du2="du --max-depth=2 -h "

alias egrep="egrep --color=auto --line-buffered"
alias hist="history | grep"
alias psg="ps aux | egrep "

alias tig="GIT_LFS_SKIP_SMUDGE=1 git"

alias clip="xclip -sel clip"
alias X="xclip -sel clip"

alias gt="gotestsum --format testname"

export ED=vim
alias v="vim"
alias n="vim"
alias code="vim"
alias edit="vim"

alias uuid="cat /proc/sys/kernel/random/uuid"

alias hugodev="hugo serve --bind 0.0.0.0 --buildDrafts --buildFuture"
alias hugodraft="hugo serve --bind 0.0.0.0 --buildDrafts"
alias hugofut="hugo serve --bind 0.0.0.0 --buildFuture"
alias hugoprd="hugo serve --bind 0.0.0.0"

function clean-vim () {
    rm -rf $HOME/.vimswap $HOME/.vimbackup
}

alias cloc="cloc --read-lang-def=$HERE/../assets/cloc_defs.txt  --exclude-dir=cue.mod,vendor,node_modules"

function fclip() {
    cat $1 | xclip -sel clip
}

alias rl="fc -s"

function ping-godoc() {
    project=$1
    version=$2

    curl https://proxy.golang.org/${project}/@v/${version}.info
}

alias grep="egrep"

function find-sed-replace () {
    NAME=$1
    PATTERN=$2
    find . -type f -name "$NAME" -print0 | xargs -0 sed -i "$PATTERN"
}
