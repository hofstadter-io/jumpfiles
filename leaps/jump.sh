# Within this file all ENV variables need to have a unique (shared) prefix.
# The typical patter is to match the command letter, filename, and prefix the same.
# System wide variables belong in the bases or overlay directory.

# This directory (leaps) - here we can use the same prefix arcross files at the same level (different dirs still require different prefixes, which is why we do it)
JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Source the common config
source $JDIR/../config.sh

# Leap specific ENV vars
J_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"


# Our main "jumpfile" or leap, the one letter command to get stuff done
# We actually use a longer name here and alias later so you can override it
function j_orig () {
# Grab the first arg, then shift and switch
# TODO, consider adding getops here too
  ARG=$1
  shift 1
  case $ARG in

  # This secrion is key to the jumpfile, it enables you to
  # quickly view, open, edit, save, and refresh the settings
  # enabling easy recording of repeated or short-term commands

  # Simply cat out the file as a help command and avoid doc drift
  "?" | help           ) cat $J_JUMP_FILE_LOCATION ;;
  # Edit this file from anywhere, when you are done save and reload
  # Your editor is defined in config.sh
  E | edit             ) $JUMP_EDITOR $J_JUMP_FILE_LOCATION ;;
  # Refresh the settings in the current terminal
  R | reload | refresh ) source $J_JUMP_FILE_LOCATION ;;
  # jump to the source directory (repo root on your system)
  J | jump             ) cd $JDIR/.. ;;

  # https://hackurls.com
  news ) wget -O - hackurls.com/ascii | less ;;


  #
  #####  This is a starter template for other leap files, see them for examples of what to put here
  #

  *) 
    echo "unknown jump '$1'"
    echo "use: 'j ?' for help"
    echo "or:  'j E' to edit"
    echo "and: 'j R' to reolaod"
    ;;
  esac
}
export -f j_orig
alias j="j_orig"

function jump-save () {
    suffix=$(date +"%Y-%m-%d-%H%M")
    name=${1:-$USER-share-$suffix}
    push $JDIR
    git add .
    git checkout -b $name
    git commit -m "$name"
    git push -u origin $name
    popd
}

function jump-share () {
    suffix=$(date +"%Y-%m-%d-%H%M")
    name=${1:-$USER-share-$suffix}
    pushd $JDIR
    git add .
    git checkout -b $name
    git commit -m "$name"
    git push -u origin $name
    popd
}

