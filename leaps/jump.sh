JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
J_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

function j () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help           ) cat $J_JUMP_FILE_LOCATION ;;
  E | edit             ) $JUMP_EDITOR $J_JUMP_FILE_LOCATION ;;
  R | RELOAD | reload  ) source $J_JUMP_FILE_LOCATION ;;
  J | jump             ) cd $JDIR/.. ;;

  #
  #### Copy me and add cases like you see in the other files
  #### Be sure to change the function name and add it to the index.sh
  #

  *) 
    echo "unknown jump '$1'"
    echo "use: 'j ?' for help"
    echo "or:  'j E' to edit"
    echo "and: 'j R' to reolaod"
    ;;
  esac
}
