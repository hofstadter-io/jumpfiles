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
  t  | tmp          ) cd $CUEBASE/tmp  ;;
  C  | cmd          ) cd $CUEBASE/cue/cmd/cue ;;
  w  | web  | site  ) cd $CUEBASE/cuelang.org  ;;
  ex | examples     ) cd $CUEBASE/examples  ;;

  v  | vim          ) cd $HOME/.EverVim/bundle/cue.vim  ;;
  V  | VIM          ) cd $CUEBASE/cue.vim  ;;
  j  | jjo          ) cd $CUEBASE/jjo-vim-cue  ;;

  *) 
    echo "unknown jump '$1'"
    echo "use: 'c ?' for help"
    echo "or:  'c E' to edit"
    echo "and: 'c R' to reolaod"
    ;;
  esac
}
