ref: https://cloudnative-pg.io/documentation/1.25/installation_upgrade/

````
kubectl apply --server-side -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.25/releases/cnpg-1.25.1.yaml
````

kubectl get cluster

## Install cnpg plugins

````
curl -sSfL \
  https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh | \
  sudo sh -s -- -b /usr/local/bin
````

kubectl cnpg status <cluster-name>