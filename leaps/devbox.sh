#!/usr/bin/env bash

LDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DEVBOX_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

. $LDIR/../config.sh

USAGE () {
    echo "unknown jump '$1'"
    echo "use: 'devbox ?' for help"
    echo "or:  'devbox E' to edit"
    echo "and: 'devbox R' to reolaod"
}

devbox () {
    WHAT=${1}
    shift 1

    case $WHAT in

        # Normal jumpfile stuff
        "?" | help           ) cat $DEVBOX_JUMP_FILE_LOCATION ;;
        E | edit             ) $JUMP_EDITOR $DEVBOX_JUMP_FILE_LOCATION ;;
        R | RELOAD | reload  ) source $DEVBOX_JUMP_FILE_LOCATION ;;
        J | jump             ) cd $LDIR/.. ;;

        #
        #####  Devbox
        #

        info )
            echo "devbox"
            echo "-------------------------------"
            echo "name:      $GCLOUD_DEVBOX_NAME"
            echo "account:   $GCLOUD_ACCOUNT"
            echo "project:   $GCLOUD_PROJECT"
            echo "zone:      $GCLOUD_ZONE"
            echo ""
            echo "network:   $GCLOUD_NETWORK"
            echo "subnet:    $GCLOUD_SUBNET"
            echo "private:   $GCLOUD_PRIVATE"
            echo ""
            echo "machine:   $GCLOUD_MACHINE_TYPE"
            echo "disktype:  $GCLOUD_DISK_TYPE"
            echo "disksize:  $GCLOUD_DISK_SIZE"
            ;;


        boot )
            devbox up
            # wait for IAP to come up because that takes a little longer
            sleep 120
            devbox setup
            ;;
        up | create )

            gcloud compute instances create $GCLOUD_DEVBOX_NAME \
              $GCLOUD_DEVBOX_LABELS \
              $GCLOUD_NETWORK_TAGS \
              --account $GCLOUD_ACCOUNT \
              --project $GCLOUD_PROJECT \
              --zone $GCLOUD_ZONE \
              --network $GCLOUD_NETWORK \
              --subnet $GCLOUD_SUBNET \
              $GCLOUD_PRIVATE \
              --machine-type $GCLOUD_MACHINE_TYPE \
              --boot-disk-type $GCLOUD_DISK_TYPE \
              --boot-disk-size $GCLOUD_DISK_SIZE \
              --image-project ${GCLOUD_IMAGE_PROJECT} \
              --image-family  ${GCLOUD_IMAGE_FAMILY} \
              $@
            return

        ;;

        start )
            gcloud compute instances start $GCLOUD_DEVBOX_NAME \
              --quiet \
              --account $GCLOUD_ACCOUNT \
              --project $GCLOUD_PROJECT \
              --zone $GCLOUD_ZONE $@
        ;;

        stop )
            gcloud compute instances stop $GCLOUD_DEVBOX_NAME \
              --quiet \
              --account $GCLOUD_ACCOUNT \
              --project $GCLOUD_PROJECT \
              --zone $GCLOUD_ZONE $@
        ;;

        down | delete )
            gcloud compute instances delete $GCLOUD_DEVBOX_NAME \
              --quiet \
              --account $GCLOUD_ACCOUNT \
              --project $GCLOUD_PROJECT \
              --zone $GCLOUD_ZONE $@
        ;;

        login | ssh )
            gcloud compute ssh $GCLOUD_DEVBOX_NAME \
              --account $GCLOUD_ACCOUNT \
              --project $GCLOUD_PROJECT \
              --zone $GCLOUD_ZONE $@
        ;;

        setup )
            devbox run base
            devbox run docker
            devbox run tools
        ;;

        platform )
            devbox run base
            devbox run docker
            devbox run tools
        ;;

        r | run )
            echo "running: $@"
            CMD=$@
            case $1 in
                hack)     CMD=$GCLOUD_DEVBOX_HACK ;;
                setup)    CMD=$GCLOUD_DEVBOX_SETUP_ALL ;;
                base)     CMD=$GCLOUD_DEVBOX_SETUP_BASE ;;
                docker)   CMD=$GCLOUD_DEVBOX_SETUP_DOCKER ;;
                tools)    CMD=$GCLOUD_DEVBOX_SETUP_TOOLS ;;
                clone)    CMD=$GCLOUD_DEVBOX_SETUP_CLONE ;;
                kind)     CMD=$GCLOUD_DEVBOX_SETUP_KIND ;;
            esac

            gcloud compute ssh $GCLOUD_DEVBOX_NAME \
              --account $GCLOUD_ACCOUNT \
              --project $GCLOUD_PROJECT \
              --zone $GCLOUD_ZONE \
              -- << ENDSSH
$CMD
ENDSSH
        ;;

        platform )
            echo "tbd..."
            ;;
        *) USAGE ;;
    esac

    # Boot VM
}

read -r -d '' GCLOUD_DEVBOX_HACK << ENDSSH 
#!/usr/bin/env bash
set -x
# set -euo pipefail

echo ""
echo ""
echo "hello \$USER, running your hack as you asked..."
echo ""

ENDSSH

read -r -d '' GCLOUD_DEVBOX_SETUP_ALL << ENDSSH 

#### BASE
$GCLOUD_DEVBOX_SETUP_BASE

#### TOOLS
$GCLOUD_DEVBOX_SETUP_TOOLS

#### DOCKER
$GCLOUD_DEVBOX_SETUP_DOCKER

#### END
ENDSSH

read -r -d '' GCLOUD_DEVBOX_SETUP_BASE << ENDSSH 
echo ""
echo ""
echo "hello \$USER, setting up your VM"
echo ""

sudo su

apt update -y
apt upgrade -y

apt install -y \
  ansible \
  git \
  tree \
  unzip \
  vim \
  wget

echo "export PATH=$PATH:/usr/local/go/bin" >> .profile

ENDSSH

read -r -d '' GCLOUD_DEVBOX_SETUP_DOCKER << ENDSSH 
sudo su

# Adapted from
# https://docs.docker.com/engine/install/debian/

# Cleanup
apt-get remove -y docker docker-engine docker.io containerd run

# Dependencies
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Docker repo
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	\$(lsb_release -cs) \
	stable"

# Install Docker
apt-get update -y
apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io

# back into regular user
exit

# Non-sudo
# sudo groupadd docker (already added during install)
sudo usermod -aG docker \$USER

ENDSSH

read -r -d '' GCLOUD_DEVBOX_SETUP_TOOLS << ENDSSH 
sudo su

if [[ -f /usr/local/bin/kubectl ]]; then
  echo "kubectl is already installed."
else
  curl -LO https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl
  chmod +x kubectl
  mv kubectl /usr/local/bin/kubectl
fi

if [[ -f /usr/local/go/bin/go ]]; then
  echo "Go is already installed."
else
  curl -LO https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz
  tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
fi

if [[ -f /usr/local/bin/cue ]]; then
  echo "Cue is already installed."
else
  curl -LO https://github.com/cuelang/cue/releases/download/v$CUE_VERSION/cue_${CUE_VERSION}_Linux_x86_64.tar.gz
  mkdir /tmp/cue
  tar -C /tmp/cue -xzf cue_${CUE_VERSION}_Linux_x86_64.tar.gz
  mv /tmp/cue/cue /usr/local/bin/cue
fi

if [[ -f /usr/local/bin/hof ]]; then
  echo "Hof is already installed."
else
  curl -LO https://github.com/hofstadter-io/hof/releases/download/v$HOF_VERSION/hof_${HOF_VERSION}_Linux_x86_64
  mv hof_${HOF_VERSION}_Linux_x86_64 /usr/local/bin/hof
  chmod +x /usr/local/bin/hof
fi

if [[ -f /usr/local/bin/mkcert ]]; then
  echo "MkCert is already installed."
else
  curl -LO https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64
  chmod +x mkcert-v${MKCERT_VERSION}-linux-amd64
  mv mkcert-v${MKCERT_VERSION}-linux-amd64 /usr/local/bin/mkcert
fi

if [[ -f /usr/local/bin/helm ]]; then
  echo "Helm is already installed."
else
  curl -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
  mkdir -p /tmp/helm 
  tar -C /tmp/helm -xf helm-v${HELM_VERSION}-linux-amd64.tar.gz
  chmod +x /tmp/helm/linux-amd64/helm
  mv /tmp/helm/linux-amd64/helm /usr/local/bin/helm
fi

if [[ -f /usr/local/bin/kind ]]; then
  echo "KinD is already installed."
else
  curl -LO https://kind.sigs.k8s.io/dl/v$KIND_VERSION/kind-$(uname)-amd64
  chmod +x kind-$(uname)-amd64
  mv kind-$(uname)-amd64 /usr/local/bin/kind
fi

if [[ -f /usr/local/bin/terraform ]]; then
  echo "Terraform is already installed."
else
  curl -LO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
  # unzip terraform_${TF_VERSION}_linux_amd64.zip
fi


rm -f *.tar.gz *.zip

ENDSSH



read -r -d '' GCLOUD_DEVBOX_SETUP_CLONE << ENDSSH 
# clone repos here
ENDSSH

read -r -d '' GCLOUD_DEVBOX_SETUP_KIND << ENDSSH 
# setup kind with your kubernetes dev setup
ENDSSH

read -r -d '' GCLOUD_DEVBOX_SETUP_SOFTWARE << ENDSSH 
# install things on kind here
ENDSSH


