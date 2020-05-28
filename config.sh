#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Jumpfile editor
JUMP_EDITOR=${ED:-nvim}

#
##### Versions
#

GO_VERSION=1.14.3
CUE_VERSION=0.2.0
HOF_VERSION=0.5.4
TF_VERSION=0.12.26
# cfssl version instead?
MKCERT_VERSION=1.4.1
HELM_VERSION=3.2.1
KIND_VERSION=0.8.1
K8S_VERSION=1.18.3




#
#### devbox / devk8s
#

# TODO, separate disk for user home directory (and this might be changing with SystemD?)

### Common gcloud config
GCLOUD_ACCOUNT=${GCLOUD_ACCOUNT:-}
GCLOUD_PROJECT=${GCLOUD_PROJECT:-}
GCLOUD_ZONE=${GCLOUD_ZONE:-us-central1-a}
GCLOUD_NETWORK=${GCLOUD_NETWORK:-deveph-network}
GCLOUD_SUBNET=${GCLOUD_SUBNET:-deveph-subnet}
# You can use this if the proper network, subnet, and NAT are setup
#GCLOUD_PRIVATE="--no-address"


#
### DevBox
#
GCLOUD_DEVBOX_NAME=${GCLOUD_DEVBOX_NAME:-devbox-$USER}
GCLOUD_DEVBOX_LABELS="--labels jumpfile=devbox,creator=$USER"
GCLOUD_DEVBOX_NETTAGS="--tags devbox"

#GCLOUD_IMAGE_PROJECT="ubuntu-os-cloud"
#GCLOUD_IMAGE_FAMILY="ubuntu-1604-lts"
#GCLOUD_IMAGE_FAMILY="ubuntu-2004-lts"
GCLOUD_IMAGE_PROJECT="debian-cloud"
GCLOUD_IMAGE_FAMILY="debian-10"

# VM config
GCLOUD_MACHINE_TYPE="n1-standard-4"
GCLOUD_DISK_TYPE="pd-ssd"
GCLOUD_DISK_SIZE="100GB"


#
### GKE (devk8s) config
#

GCLOUD_DEVBOX_NAME=${GCLOUD_DEVBOX_NAME:-devk8s-$USER}
GCLOUD_DEVK8S_LABELS="--labels jumpfile=devk8s,creator=$USER"
GCLOUD_DEVK8S_NETTAGS="--tags devk8s"




# source custom after defaults
if [ -f $HOME/.jumpfile.config.sh ]; then 
    . $HOME/.jumpfile.config.sh
fi
if [ -f $HOME/.jumpfile.secret.sh ]; then 
    . $HOME/.jumpfile.secret.sh
fi


