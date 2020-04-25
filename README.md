# jumpfiles

A pattern for self contained scripts which allow you to jump around linux and run common commands. The key is that it's easy to update and reload the file. 


### The J Jumpfile

This is the base jumpfile. It has 3 cases which make for a good UX.
Quickly view, edit, extend, and reload your jumpfiles.

```bash
JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
J_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

function j () {
  ARG=$1
  shift 1
  case $ARG in

  #
  ### The following 3 cases are key to the jump files UX
  ### quickly add, update, and reload new cases and ops.
  #
  
  # Cat this jump file
  "?" | help           ) cat $J_JUMP_FILE_LOCATION ;;
  
  # Edit this jump file
  E | edit             ) $JUMP_EDITOR $J_JUMP_FILE_LOCATION ;;
  
  # Relaod this jump file
  R | RELOAD | reload  ) source $J_JUMP_FILE_LOCATION ;;
  
  
  # Navigate to your jumpfils repo
  J | jump             ) cd $JDIR/.. ;;

  
  #
  ### Copy me and add cases like you see in the other files
  ### Be sure to change the function name and add it to the index.sh
  #

  
  # Print all other cases
  *) 
    echo "unknown jump '$1'"
    echo "use: 'j ?' for help"
    echo "or:  'j E' to edit"
    echo "and: 'j R' to reolaod"
    ;;
  esac
}
```

### The C (for Cuelang) Jumpfile

This one is based on a dev setup for [Cuelang](https://cuelang.org)

```
JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
C_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

CUEBASE=$HOME/hof/cuelang
CUEMODS=$HOME/hof/hofio/cuemods

function c () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help             ) cat $C_JUMP_FILE_LOCATION ;;
  E   | edit             ) $JUMP_EDITOR $C_JUMP_FILE_LOCATION ;;
  R   | RELOAD | reload  ) source $C_JUMP_FILE_LOCATION ;;

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
```
