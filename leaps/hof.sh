JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
H_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

HOFBASE=$HOME/hof
HOFTOOLS=$HOFBASE/tools
HOFMODS=$HOFBASE/mods
HOFPLAT=$HOFBASE/studios/old-platform

function h_orig () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help           ) cat $H_JUMP_FILE_LOCATION ;;
  E | edit             ) $JUMP_EDITOR $H_JUMP_FILE_LOCATION ;;
  R | RELOAD | reload  ) source $H_JUMP_FILE_LOCATION ;;

  # Jump to hof leaps
  J ) cd $HOFBASE/jumpfiles ;;

  # base
  H | B | base | home  ) cd $HOME/hof/$@  ;;


  # Documentation
  d  | docs  ) cd $HOME/hof/websites/hof-docs ;;
  w  | web   ) cd $HOME/hof/websites/hof.io ;;
	D  | demos ) cd $HOME/hof/demos/$@ ;;

  # Script
  hls      ) cd $HOFBASE/hof/script ;;
  hlst     ) cd $HOFBASE/hof/script/tests ;;

  # Hof Tool
  h  | hof    ) cd $HOFBASE/hof/$@ ;;
  f  | flows  ) cd $HOFBASE/flows/$@ ;;
  fe | flowex ) cd $HOFBASE/flow-examples/$@ ;;
  hc | cmd    ) cd $HOFBASE/hof/cmd/hof/ ;;
  ht | htest  ) cd $HOFBASE/hof/test/$@ ;;

  # Other projects
  S  | saas   ) cd $HOFBASE/_saas/$@ ;;
  St | saas   ) cd $HOFBASE/_saas/test/$@ ;;
  A  | awesome ) cd $HOFBASE/_awesome ;;

  C  | cuelm  ) cd $HOFBASE/cuelm/$@ ;;
  harmony ) cd $HOFBASE/harmony/$@ ;;
  harmony-cue ) cd $HOFBASE/harmony-cue/$@ ;;
  dp | dplans ) cd $HOFBASE/dagger-plans/$@ ;;

  # Modules
  # hofmods (public primary modules, developed with hof)
  m | mod | mods ) cd $HOFMODS/$@ ;;
  cli            ) cd $HOFMODS/cli ;;
  cue | cuefig   ) cd $HOFMODS/cuefig ;;
  cfg | config   ) cd $HOFMODS/config ;;
  brand          ) cd $HOFMODS/brand ;;
  model          ) cd $HOFMODS/model ;;
  sql            ) cd $HOFMODS/sql ;;
  datastore      ) cd $HOFMODS/datastore ;;
  server         ) cd $HOFMODS/server ;;
  client         ) cd $HOFMODS/client ;;
  devenv         ) cd $HOFMODS/devenv ;;
  build          ) cd $HOFMODS/build ;;
  test           ) cd $HOFMODS/test ;;
  k8s            ) cd $HOFMODS/k8s ;;
  devops         ) cd $HOFMODS/devops ;;
  o | openapi    ) cd $HOFMODS/openapi ;;

  T )
    pushd $HOFBASE/hof/ci/test > /dev/null
    cue cmd $@ run-tests
    popd > /dev/null
    ;;

  # Finally catch anything we don't know
  *) 
    echo "unknown jump '$1'"
    echo "use: 'h ?' for help"
    echo "or:  'h E' to edit"
    echo "and: 'h R' to reload"
    ;;
  esac

}
export -f h_orig

alias _Hi="pushd $HOFBASE/hof/cmd/hof > /dev/null; go install; popd > /dev/null"
alias ts="testscript"
