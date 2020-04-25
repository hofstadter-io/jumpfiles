alias kbuectl="kubectl"

alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kl="kubectl logs"
alias kd="kubectl delete"
alias ke="kubectl edit"
alias kx="kubectl exec -it"

alias kt="kubetail"

alias km="watch -n 3 kubectl get ingress,svc,ep,deploy,pods,cm"

alias forward-prometheus="kubectl get pods -l app=prometheus -o name | sed 's/^.*\///' | xargs -I{} kubectl port-forward {} 9090:9090"
alias forward-alertmanager="kubectl get pods -l app=alertmanager -o name | sed 's/^.*\///' | xargs -I{} kubectl port-forward {} 9093:9093"

alias known-clusters="cat ~/.kube/config | geb adhoc -o json | jq ".clusters[].name" | sort"

