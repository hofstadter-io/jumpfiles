alias itsWhalesAllTheWayDown='docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker)'
alias dNd='itsWhalesAllTheWayDown'

alias dc="docker-compose"

alias dps="docker ps"
alias dpsa="docker ps -a"
alias dpsaq="docker ps -a -q"
function dpc() {
    for dead in `dpsaq`
    do
        docker rm $dead
    done
}
function dpcKILL() {
    for d in `dpsaq`
    do
        docker rm -f $d
    done
}

alias di="docker images | egrep -v REPO | sort"
alias din="docker images | egrep '<none>'"
alias dina="din | awk '{print \$3}'"
function dpi() {
    for none in `dina`
    do
        docker rmi $none
    done
}
function dpiALL() {
    for image in `di | awk '{print $3}'`
    do
        # echo "deleting $image"
        docker rmi $image
    done
}
function dpiNUKE() {
    for image in `di | awk '{print $3}'`
    do
        # echo "deleting $image"
        docker rmi -f $image
    done
}

function dpv() {
  docker volume rm $(docker volume ls -qf dangling=true)
}

alias drm="docker rm"
alias dlog="docker logs"

# for docker-machine
function dmenv() {
    eval $(docker-machine env $1)
}

