helm is like a package manager, let say similiar to docker hub

add a repo
helm repo <name> <repo link>

check current added repo
helm repo ls

install/deploy container
helm install <project_name> <repo_name>

to check which helm were used/deployed
helm ls --namespace <namespace>

helm history <project_name>
helm rollback <project_name> <revision_num>