
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


