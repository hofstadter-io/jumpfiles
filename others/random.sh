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
