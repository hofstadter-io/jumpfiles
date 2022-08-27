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
  H   | home             ) cd $CUEBASE  ;;

  # cue source
  c  | cue          ) cd $CUEBASE/cue  ;;
  s  | src          ) cd $CUEBASE/cue  ;;
  g  | gerrit       ) cd $CUEBASE/gerrit  ;;
  h  | hof          ) cd $CUEBASE/hof-cue  ;;
  t  | tmp          ) cd $CUEBASE/tmp  ;;
  C  | cmd          ) cd $CUEBASE/cue/cmd/cue ;;
  w  | web          ) cd $CUEBASE/cuelang.org  ;;
  d  | site         ) cd $CUEBASE/cuetorials.com ;;
  r  | repro        ) cd $CUEBASE/repro/$@ ;;
  ex | examples     ) cd $CUEBASE/examples  ;;
	u  | utils        ) cd $CUEBASE/cuetils ;;


  v  | lsp          ) cd $HOME/nvim/tree-sitter-cue  ;;
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

alias _c="cuetils" 
alias _cf="cuetils flow" 

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

function _Ch () {
  pushd $CUEBASE/hof-cue/cmd/cue >> /dev/null
  go install
  popd >> /dev/null
}

function _CUi () {
  pushd $CUEBASE/cuetils/cmd/cuetils >> /dev/null
  go install
  popd >> /dev/null
}

alias dlvcue="dlv exec $(which cue)"
