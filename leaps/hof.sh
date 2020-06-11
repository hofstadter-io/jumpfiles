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
  d  | docs | site ) cd $HOME/hof/websites/site ;;
  od | old-docs    ) cd $HOME/hof/websites/studios-docs ;;

  # Other
  yagu     ) cd $HOFBASE/yagu ;;

  # Hof Tool
  h  | hof    ) cd $HOFBASE/hof/$@ ;;
  hc | cmd    ) cd $HOFBASE/hof/cmd/hof/ ;;
  ht | htest  ) cd $HOFBASE/hof/test/$@ ;;

  # Other projects
  S  | saas   ) cd $HOFBASE/_saas/$@ ;;
  St | saas   ) cd $HOFBASE/_saas/test/$@ ;;
  A  | awesome ) cd $HOFBASE/_awesome ;;

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
    echo "and: 'h R' to reolaod"
    ;;
  esac

}
export -f h_orig
alias h="h_base"

alias hmv="hof mod vendor"
alias hmvc="hof mod vendor cue"

alias _g="hof gen"
alias _a="hof add"
alias _m="hof model"
alias _c="hof cmd"
alias _gen="hof gen"
alias _add="hof add"
alias _model="hof model"
alias _cmd="hof cmd"

alias _L="hof label"
alias _G="hof get"
alias _A="hof apply"
alias _label="hof label"
alias _get="hof get"
alias _apply="hof apply"
alias _create="hof create"
alias _delete="hof delete"

alias _d="cue def"
alias _e="cue eval"
alias _x="cue export"
alias _i="cue import"
alias _def="cue def"
alias _eval="cue eval"
alias _export="cue export"
alias _import="cue import"

alias _v="hof mod vendor"
alias _vendor="hof mod vendor"
alias _vc="hof mod vendor cue"

alias _D="hof diff"
alias _S="hof status"

alias _diff="hof diff"
alias _status="hof status"

alias _fetch="hof fetch"
alias _pull="hof pull"
alias _push="hof push"
alias _propose="hof propose"

alias _ui="hof ui"
alias _tui="hof tui"
alias _repl="hof repl"
alias _hack="hof hack"

alias _auth="hof auth"
alias _config="hof config"
alias _secret="hof secret"
alias _context="hof context"
alias _project="hof project"
alias _workspace="hof workspace"

alias _feedback="hof feedback"
alias _high="echo \"what's the deal with ℵ{🐢🐢🐢🐢} and infinite coincidences?\""
alias _yo="hof yo"
alias _🐢="while true; do echo 🐢; sleep 1; done"

function _ℵ () {
cat << EOF | python
WIDTH = 81
HEIGHT = 5
 
lines=[]
def cantor(start, len, index):
    seg = len / 3
    if seg == 0:
        return None
    for it in xrange(HEIGHT-index):
        i = index + it
        for jt in xrange(seg):
            j = start + seg + jt
            pos = i * WIDTH + j
            lines[pos] = ' '
    cantor(start,           seg, index + 1)
    cantor(start + seg * 2, seg, index + 1)
    return None
 
lines = ['*'] * (WIDTH*HEIGHT)
cantor(0, WIDTH, 1)
 
for i in xrange(HEIGHT):
    beg = WIDTH * i
    print(''.join(lines[beg : beg+WIDTH]))
EOF
}
export -f _ℵ

alias _Hv="pushd $HOFBASE/hof > /dev/null; hof mod vendor; popd > /dev/null"
alias _Hg="pushd $HOFBASE/hof > /dev/null; hof gen; popd > /dev/null"
alias _Hb="pushd $HOFBASE/hof/cmd/hof > /dev/null; go build; popd > /dev/null"
alias _Hi="pushd $HOFBASE/hof/cmd/hof > /dev/null; go install; popd > /dev/null"
alias _HG="_Hv && _Hg"
alias _Hr="_Hg && _Hb"
alias _HR="_Hg && _Hi"
alias _HB="_Hv && _Hg && _Hb"
alias _HI="_Hv && _Hg && _Hi"
alias _H="pushd $HOFBASE/hof > /dev/null; hof mod vendor && hof gen && _Hi; popd > /dev/null"

# testing related
alias _Hgt="go test"
alias _Hgtr="go test ./..."
# testsuite helper when preserving cached test directories
alias _Hts="rm -rf /no-home && rm -rf .workdir && go test"
alias _Htst="rm -rf /no-home && rm -rf .workdir && go test -run Tests"
alias _Htsb="rm -rf /no-home && rm -rf .workdir && go test -run Bugs"
