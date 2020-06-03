JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DEVENV_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

DEVENV_BASE=$JDIR/../lib

function devenv_jump () {
    pushd $DEVENV_BASE > /devnull
    $@
    popd > /devnull
}

alias d="devenv"

function devenv () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help             ) cat $DEVENV_JUMP_FILE_LOCATION ;;
  E   | edit             ) $JUMP_EDITOR $DEVENV_JUMP_FILE_LOCATION ;;
  R   | RELOAD | reload  ) source $DEVENV_JUMP_FILE_LOCATION ;;

  flags )
    devenv_jump cue eval -A --out=cue -e "#Schema" $@ 
    ;;

  peek )
    devenv_jump cue eval --out=cue -e "#DevenvActual" $@ 
    ;;

  info )
    devenv_jump cue cmd $@ info
    ;;

  list )
    devenv_jump cue cmd $@ list
    ;;

  view )
    devenv_jump cue cmd $@ view
    ;;

  login | ssh )
    # This one is special because we need interactive input
    pushd $DEVENV_BASE > /devnull
    CMD=$(cue cmd $@ login | tr -d "\\")
    echo $CMD
    $CMD
    popd > /devnull
    ;;

  creds )
    devenv_jump cue cmd $@ creds
    ;;

  start | new | boot )
    devenv_jump cue cmd $@ start
    ;;

  stop | delete | del )
    devenv_jump cue cmd $@ stop
    ;;

  setup | prep )
    devenv_jump cue cmd $@ setup
    ;;

  platform | install )
    devenv_jump cue cmd $@ platform
    ;;

  *) 
    echo "unknown jump '$1'"
    echo "use: 'devenv ?' for help"
    echo "or:  'devenv E' to edit"
    echo "and: 'devenv R' to reolaod"
    ;;
  esac
}
