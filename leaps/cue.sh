JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
C_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

CUEBASE=$HOME/cue

function c () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help             ) cat $C_JUMP_FILE_LOCATION ;;
  E   | edit             ) $JUMP_EDITOR $C_JUMP_FILE_LOCATION ;;
  R   | RELOAD | reload  ) source $C_JUMP_FILE_LOCATION ;;

  # cue source
  b  | base | home  ) cd $CUEBASE  ;;
  c  | cue          ) cd $CUEBASE/cue  ;;
  s  | src          ) cd $CUEBASE/cue  ;;
  g  | gerrit       ) cd $CUEBASE/gerrit  ;;
  t  | tmp          ) cd $CUEBASE/tmp  ;;
  C  | cmd          ) cd $CUEBASE/cue/cmd/cue ;;
  w  | web  | site  ) cd $CUEBASE/cuelang.org  ;;
  d  | T | tut      ) cd $CUEBASE/cuetorials.com ;;
  r  | repro        ) cd $CUEBASE/repro ;;
  ex | examples     ) cd $CUEBASE/examples  ;;

  v  | vim          ) cd $HOME/.EverVim/bundle/cue.vim  ;;
  V  | VIM          ) cd $CUEBASE/cue.vim  ;;
  j  | jjo          ) cd $CUEBASE/jjo-vim-cue  ;;

  aoc | code        ) cd $CUEBASE/cuetorials.com/code/advent-of-code/2020 ;;
  AOC | content     ) cd $CUEBASE/cuetorials.com/content/advent-of-code ;;

  *) 
    echo "unknown jump '$1'"
    echo "use: 'c ?' for help"
    echo "or:  'c E' to edit"
    echo "and: 'c R' to reload"
    ;;
  esac
}

function _Ci () {
  pushd $CUEBASE/cue/cmd/cue >> /dev/null
  go install
  popd >> /dev/null
}

function _Cg () {
  pushd $CUEBASE/gerrit/cmd/cue >> /dev/null
  go install
  popd >> /dev/null
}

alias dlvcue="dlv exec $(which cue)"
