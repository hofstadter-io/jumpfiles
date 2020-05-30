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

  #
  #####  This is a starter template for other leap files, see the my neighbors for examples of what you can put here
  #

  *) 
    echo "unknown jump '$1'"
    echo "use: 'j ?' for help"
    echo "or:  'j E' to edit"
    echo "and: 'j R' to reolaod"
    ;;
  esac
}

# export our orig name so that others can extend them in their customizations without the need to edit this file
export -f j_orig

# alias to our preferred shortie
alias j="j_orig"

```

### Installation

1. Clone repository
2. Run install

```
git clone https://github.com/hofstadter-io/jumpfiles
./jumpfiles/install.sh [location]
```

By default, location is `$HOME/.profile`


### Customization

There are three files in your home directory
where you can hook into the Jumpfile system.

- `.jumpfile.custom.sh` - anything you want loaded with new terminal sessions
- `.jumpfile.config.sh` - for non-sensitive, per-run command context not normally needed
- `.jumpfile.secret.sh` - for secret and sensative information, the same as config but intentionally separated

Hofstadter Jumpfiles also makes it easy to create your own jumpfiles.
For this, we will be making a separate repository and adding our entrypoint
to the `.jumpfile.custom.sh` hook.

```
# Start a new directory
cd $HOME
mkdir -p my-jumps/leaps

# Copy jumpfile
cp jumpfile/leaps/jump.sh my-jumps/leaps/xxx.sh  # get your mind out of the gutter....

# Add the jumpfile to your $HOME/.jumpfile.custom.sh 
echo '. $HOME/my-jumps/leaps/xxx.sh' >> $HOME/.jumpfile.custom.sh
```

When you first start editing this file, you will need to do the following things:

- Change `JDIR` to something unique, this is the leapfile directory and the same across
  all of your custom leaps, but unique between leap (pads?) directories
- Change `J_JUMP_FILE_LOCATION`, similar to JDIR, but unique across __ALL__ jumpfiles
- Change the shortcut name to your preferences, you will also likely want to remove the `J` subcommand or repoint to your new repo
- Git init and push. We highly recommend you keep your jumps in version control. You will be able to receive regular updates from us, and if you have a cool addition, we love PRs!

### Working with Jumpfiles

One of the main benefits to Jumpfiles is
the ability to quickly add and start using
commands you'd like to shorten to a few keystrokes.

Here are some common command sequences we find ourselves doing.

```
# On a per Jumpfile basis
$ ... some long command ... # copy!
$ h E                       # open our jumpfile in neovim, paste command with new 1-2 char shortcut, ":x" to save and close
$ h R                       # refresh this particular jumpfile, each jumpfile has these same commands
$ h __                      # profit 🤑

# For the jumpfile system (since there's actually a few file classes now)
$ j J                       # Jump to our jumpfile repository
$ n                         # open the current directory in neovim

# (in another terminal)
$ ... try out whatever it is we are working on (devenv.sh and generally modifying cue code are good examples)
$ jumpfile-refresh          # the 'j' Jumpfile exposes a full refresh command
$ ... try again, repeat as needed
```

You can find many examples in this repository's `leaps/*` files.
Here are a few we find ourselves using:

```
# jump to a directory, and maybe subdir if args
h  | hof    ) cd $HOFBASE/hof/$@ ;;

# run a command leveraging variables
login | ssh )
    gcloud compute ssh $VM_NAME \
      --project $PROJECT \
      --zone $ZONE \
      $@
;;

# to run a number of other jumpfile shortcuts
# (taken from leaps/devenv, devenv_jump is a helper to jump to a directory with certain files in it

  launch )
    devenv boot
    devenv creds
    devenv addon logmon
    devenv addon psql-oper
    devenv addon _saas
    ;;


  start | new | boot )
    devenv_jump cue cmd $@ start
    ;;

  creds )
    devenv_jump cue cmd $@ creds
    ;;

  addon )
    A=$1
    shift 1
    devenv_jump cue cmd -t addon=$1 $@ install
    ;;

```


