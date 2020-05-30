#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Jumpfile editor
JUMP_EDITOR=${ED:-nvim}

#
##### Common configs loaded by default (only when commands are run) (but does this persist after the command? (it should not))
#

. $ROOT/cuefig/versions.sh
. $ROOT/cuefig/gcloud.sh

# source custom after defaults
if [ -f $HOME/.jumpfile.config.sh ]; then 
    . $HOME/.jumpfile.config.sh
fi
if [ -f $HOME/.jumpfile.secret.sh ]; then 
    . $HOME/.jumpfile.secret.sh
fi


