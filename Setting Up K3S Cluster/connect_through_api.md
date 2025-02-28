ref: https://docs.k3s.io/cluster-access

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get pods --all-namespaces
helm ls --all-namespaces

copy the file /etc/rancher/k3s/k3s.yaml and change the ip