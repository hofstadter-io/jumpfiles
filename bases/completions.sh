bins=(
  hof
  kubectl
)

for b in ${bins[@]}; do
  OUT=`$b completion bash`
  if [ $? -ne 0 ]; then
    echo "BIN: $b"
    continue
  fi
  . <($b completion bash)
done
