ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

leaps=(
  jump
  cue
)

others=(
  docker
  k8s
  random
)

for leap in ${leaps[@]}; do
  # echo "loading $leap"
  . $ROOT/leaps/$leap.sh
done

for other in ${others[@]}; do
  # echo "loading $leap"
  . $ROOT/others/$other.sh
done

