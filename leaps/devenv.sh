JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DEVENV_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

DEVENV_BASE=$JDIR/../lib

function devenv_jump () {
    pushd $DEVENV_BASE > /dev/null
    $@
    popd > /dev/null
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
    devenv_jump cue eval -A --out=cue -e "#DevenvFlagDefs" $@ 
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

  copy | scp )
    # TODO, need to split all args by -- so we can supply the post-set to scp (what do we want to copy?)
    # This one is special because we need interactive input
    pushd $DEVENV_BASE > /devnull
    CMD=$(cue cmd $@ copy | tr -d "\\")
    echo $CMD
    $CMD
    popd > /devnull
    ;;

  creds )
    devenv_jump cue cmd $@ creds
    ;;

  C | create | new | start )
    devenv_jump cue cmd $@ start
    ;;

  D | stop | delete | del )
    devenv_jump cue cmd $@ stop
    ;;

  S | setup | prep )
    devenv_jump cue cmd $@ setup
    ;;

  P | platform | install )
    devenv_jump cue cmd $@ platform
    ;;

  L | launch | boot )
    devenv create $@
    echo "wait just a few seconds..."
    sleep 15
    devenv setup $@
    ;;

  *) 
    echo "unknown jump '$1'"
    echo "use: 'devenv ?' for help"
    echo "or:  'devenv E' to edit"
    echo "and: 'devenv R' to reload"
    ;;
  esac
}
