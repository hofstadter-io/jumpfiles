JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
G_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

source $JDIR/../config.sh

USAGE () {
    echo "unknown jump '$1'"
    echo "use: 'a ?' for help"
    echo "or:  'a E' to edit"
    echo "and: 'a R' to reolaod"
}

# For using when launching gcloud web console in chrome
# I actually ended up using Chrome OS "shortcuts" feature for an even better experience
GCLOUD_HOF_AUTHUSER=0

g () {
  ARG=$1
  shift 1
  case $ARG in

  "?" | help           ) cat $G_JUMP_FILE_LOCATION ;;
  E | edit             ) $JUMP_EDITOR $G_JUMP_FILE_LOCATION ;;
  R | RELOAD | reload  ) source $G_JUMP_FILE_LOCATION ;;
  J | jump             ) cd $JDIR/.. ;;

  # TBD
  c | web | console ) echo "loaunch gcloud console in browser" ;;

  *) USAGE ;;
  esac
}

GA () {
  ARG=$1
  shift 1
  case $ARG in

      hof | h ) 
          #TBD, but externally defined on another leap, so include order might matter
          hof_set_gcloud_envs $@
        ;;

    # could have many account / project combinations here

      *) echo "acct should be one of [hof]" && exit 1 ;;
  esac
}

GBOX () {
    WHAT=${1}
    shift 1

    # VM_NAME
    VM_NAME=${VM_NAME:-dev-$USER}

    # Basic config
    PROJECT=""
    ZONE="us-central1-c"
    MACHINE_TYPE="n1-standard-8"
    DISK_TYPE="pd-standard"
    DISK_SIZE="250GB"
    IMAGE_FAMILY="debian-10"
    IMAGE_PROJECT="debian-cloud"
    NETWORK="studios-cluster"
    SUBNET="studios-cluster"

    case $WHAT in
        up | create )
            gcloud compute instances create $VM_NAME \
              --project $PROJECT \
              --zone $ZONE \
              --machine-type $MACHINE_TYPE \
              --boot-disk-type $DISK_TYPE \
              --boot-disk-size $DISK_SIZE \
              --image-project ${IMAGE_PROJECT} \
              --image-family  ${IMAGE_FAMILY} \
              $@
            return

              --no-address \
              --can-ip-forward \
              --network $NETWORK \
              --subnet $SUBNET \
        ;;

        login | ssh )
            gcloud compute ssh $VM_NAME \
              --project $PROJECT \
              --zone $ZONE \
              $@
        ;;

        setup )
            gcloud compute ssh $VM_NAME -- << ENDSSH 
#!/usr/bin/env bash
set -euo pipefail

echo "hello tony"

ENDSSH
        ;;

        down | delete )
            gcloud compute instances delete $VM_NAME \
              --quiet \
              --project $PROJECT \
              --zone $ZONE $@

        ;;

        *) echo "Unknown what '$WHAT'";;
    esac

    # Boot VM
}


