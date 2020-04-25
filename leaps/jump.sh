JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

function j () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help           ) cat $JUMP_FILE_LOCATION ;;
  E | edit             ) $JUMP_EDITOR $JUMP_FILE_LOCATION ;;
  R | RELOAD | reload  ) source $JUMP_FILE_LOCATION ;;

  #
  #### Copy me and add cases like you see in the other files
  #### Be sure to change the function name and add it to the index.sh
  #

  *) 
    echo "unknown jump '$1'"
    echo "use: 'c ?' for help"
    echo "or:  'c E' to edit"
    echo "and: 'c R' to reolaod"
    ;;
  esac
}
