# jumpfiles - get more done in fewer keystrokes


### Features

- quickly create, refresh, and run terminal "shortcuts" for common commands
- jump around the filesystem, run a command from anywhere^2, chain them together
- builtin Jumpfiles
    - `j`: the baseline jumpfile. `j J` will jump you to this repository on your system
    - `c`: common cue commands and many directory jumps for cue dev work
    - `h`: jumpfile for the `hof` tool with many extras
    - `g`: gcloud jumpfile, largely for managing account context. Really helpful for contractors and those who are in many GCP accounts on a daily basis.
    - `d`: or `devenv` is an advanced jumpfile (and supporting cue code) for ephemeral Kubernetes clusters and cloud vm development environments. Quickly spinup, provisions addons, and work with multiple k8s / dev vms.
- powered by https://cuelang.org for type safe scripting and importable modules and ecosystem

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


  # Navigate to your jumpfiles repo
  J | jump             ) cd $JDIR/.. ;;




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

### Installation

1. Clone repository
2. Run install
3. Setup custom

```

```

### Examples

Create an ephemeral development environment:

```
# GKE, single node, 4CPU
devenv start -t gcp -t k8s -t md -t name=my-k8s-devenv
devenv creds -t name=my-k8s-devenv
devenv list
devenv destroy -t name=my-k8s-devenv

```
