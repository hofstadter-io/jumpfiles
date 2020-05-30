#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Function to refresh the whole system
jumpfile-refresh () {
  . $ROOT/index.sh
}

# rsync overlay directory onto home dir
# This is for files for other programs where the location is important
function copy-overlay () {
    rsync -zavh $ROOT/overlay/ $HOME
}

# Base modules
bases=(
  paths
  completions
  docker
  k8s
  random
)

for base in ${bases[@]}; do
  # echo "loading $leap"
  . $ROOT/bases/$base.sh
done

# Main Jump Files
leaps=(
  # Basejumps
  jump
  cue

  # Hofstadter
  hof

  # After account specific so we can setup some meta commands based on funcs defined there
  gcloud

  # Developer ephemeral environments
  devenv
)

for leap in ${leaps[@]}; do
  # echo "loading $leap"
  . $ROOT/leaps/$leap.sh
done

# start to a Makfile base Jumpfile
alias jmake="make -f $ROOT/leaps/Makefile.testjump"


# source custom on new terminal session
if [ -f $HOME/.jumpfile.custom.sh ]; then 
    . $HOME/.jumpfile.custom.sh
fi

