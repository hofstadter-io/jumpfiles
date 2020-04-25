JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

CUEBASE=$HOME/hof/cuelang
CUEMODS=$HOME/hof/hofio/cuemods

function c () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help             ) cat $JUMP_FILE_LOCATION ;;
  E   | edit             ) $JUMP_EDITOR $JUMP_FILE_LOCATION ;;
  R   | RELOAD | reload  ) source $JUMP_FILE_LOCATION ;;

  # cue source
  B  | base | home  ) cd $CUEBASE  ;;
  S  | src  | cue   ) cd $CUEBASE/cue  ;;
  T  | tmp          ) cd $CUEBASE/tmp  ;;
  C  | cmd          ) cd $CUEBASE/cue/cmd/cue ;;
  W  | web  | site  ) cd $CUEBASE/cuelang.org  ;;
  ex | examples     ) cd $CUEBASE/examples  ;;

  # cuelibs
  m | mod |mods         ) cd $CUEMODS/$@;;
  M | model             ) cd $CUEMODS/model  ;;
  L | lib | cuelib      ) cd $CUEMODS/cuelib  ;;
  t   | T | test | TEST ) cd $CUEMODS/cuetest ;;
  st  | struct          ) cd $CUEMODS/structural ;;


  *) 
    echo "unknown jump '$1'"
    echo "use: 'c ?' for help"
    echo "or:  'c E' to edit"
    echo "and: 'c R' to reolaod"
    ;;
  esac
}
