#!/usr/bin/env bash

LDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DEVK8S_JUMP_FILE_LOCATION="${BASH_SOURCE[0]}"

. $LDIR/../config.sh

USAGE () {
    echo "unknown jump '$1'"
    echo "use: 'devk8s ?' for help"
    echo "or:  'devk8s E' to edit"
    echo "and: 'devk8s R' to reolaod"
}

devk8s () {
    WHAT=${1}
    shift 1

    ### Settings from config.sh

    case $WHAT in

        # Normal jumpfile stuff
        "?" | help           ) cat $DEVK8S_JUMP_FILE_LOCATION ;;
        E | edit             ) $JUMP_EDITOR $DEVK8S_JUMP_FILE_LOCATION ;;
        R | RELOAD | reload  ) source $DEVK8S_JUMP_FILE_LOCATION ;;
        J | jump             ) cd $LDIR/.. ;;

        info )
            echo "devk8s"
            echo "-------------------------------"
            echo "name:      $GCLOUD_DEVK8S_NAME"
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

        up | create )

            gcloud compute instances create $GCLOUD_DEVK8S_NAME \
              --labels="$GCLOUD_DEVK8S_LABELS" \
              --tags="$GCLOUD_NETWORK_TAGS" \
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

        down | delete | destroy )
            gcloud compute instances delete $GCLOUD_DEVK8S_NAME \
              --quiet \
              --account $GCLOUD_ACCOUNT \
              --project $GCLOUD_PROJECT \
              --zone $GCLOUD_ZONE $@
        ;;

        setup )
            # TBD, run commands to install common components in kubernetes
        ;;

        platform )
            # TBD, run commands to install your main platform in kubernetes
        ;;

        ### Others
        # backup / restore
        # pause / resume

        *) USAGE ;;
    esac

}

