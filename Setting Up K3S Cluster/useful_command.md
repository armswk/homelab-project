# Kubernetes Cheat Sheet

## 1️⃣ Cluster & Node Management
### 🔹 Check Cluster Info
```bash
kubectl cluster-info
kubectl version --short
```

### 🔹 Check Nodes
```bash
kubectl get nodes -o wide
kubectl describe node <node-name>
```

### 🔹 Drain a Node (for Maintenance)
```bash
kubectl drain <node-name> --ignore-daemonsets --delete-local-data
```

### 🔹 Uncordon a Node (Bring it Back)
```bash
kubectl uncordon <node-name>
```

---

## 2️⃣ Deployments & Pods
### 🔹 List Deployments
```bash
kubectl get deployments -A
kubectl describe deployment <deployment-name>
```

### 🔹 List Running Pods
```bash
kubectl get pods -A
kubectl get pods -o wide
kubectl get pod -n <namespace>
```

### 🔹 Describe a Pod (Detailed Info)
```bash
kubectl describe pod <pod-name>
```

### 🔹 View Pod Logs
```bash
kubectl logs <pod-name>
kubectl logs -f <pod-name>  # Follow logs in real-time
kubectl logs <pod-name> --previous  # View logs from previous container run
```

### 🔹 Execute a Shell Inside a Pod
```bash
kubectl exec -it <pod-name> -- /bin/sh   # Alpine/Debian-based pods
kubectl exec -it <pod-name> -- /bin/bash # Ubuntu-based pods
```

---

## 3️⃣ Services & Networking
### 🔹 List Services
```bash
kubectl get svc
kubectl get svc -A
```

### 🔹 Describe a Service
```bash
kubectl describe svc <service-name>
```

### 🔹 Expose a Pod via Service
```bash
kubectl expose pod <pod-name> --type=NodePort --port=80
```

### 🔹 Port Forward to a Pod
```bash
kubectl port-forward <pod-name> 8080:80
```
Now you can access the pod at `http://localhost:8080`.

### 🔹 Check Ingress Rules
```bash
kubectl get ingress -A
kubectl describe ingress <ingress-name>
```

---

## 4️⃣ Namespace Management
### 🔹 List All Namespaces
```bash
kubectl get namespaces
```

### 🔹 Set Default Namespace
```bash
kubectl config set-context --current --namespace=<namespace>
```

---

## 5️⃣ Config & Secrets
### 🔹 Get Kubernetes ConfigMap Data
```bash
kubectl get configmap
kubectl describe configmap <configmap-name>
kubectl get configmap <configmap-name> -o yaml
```

### 🔹 Create a ConfigMap
```bash
kubectl create configmap <configmap-name> --from-literal=key=value
```

### 🔹 Get Kubernetes Secrets
```bash
kubectl get secrets
kubectl describe secret <secret-name>
kubectl get secret <secret-name> -o yaml
```

### 🔹 Create a Secret
```bash
kubectl create secret generic <secret-name> --from-literal=username=admin --from-literal=password=supersecret
```

---

## 6️⃣ Deployment Updates & Rollbacks
### 🔹 Edit Running Deployment
```bash
kubectl edit deployment <deployment-name>
```

### 🔹 Restart a Deployment
```bash
kubectl rollout restart deployment <deployment-name>
```

### 🔹 Rollback a Deployment
```bash
kubectl rollout undo deployment <deployment-name>
```

---

## 7️⃣ Persistent Volumes & Storage
### 🔹 Check Persistent Volumes
```bash
kubectl get pv
kubectl describe pv <pv-name>
```

### 🔹 Check Persistent Volume Claims
```bash
kubectl get pvc
kubectl describe pvc <pvc-name>
```

---

## 8️⃣ Debugging & Troubleshooting
### 🔹 Check Pod Events (Debug Failures)
```bash
kubectl get events --sort-by=.metadata.creationTimestamp
```

### 🔹 View Logs of a Failed Pod
```bash
kubectl logs <pod-name> --previous
```

### 🔹 Debug a Pod (Open Shell)
```bash
kubectl exec -it <pod-name> -- /bin/sh
```

### 🔹 Debug with a BusyBox Pod
If a pod is failing, you can deploy a temporary debugging pod:
```bash
kubectl run debug --rm -it --image=busybox -- /bin/sh
```

---

## 9️⃣ Deleting Resources
### 🔹 Delete a Pod
```bash
kubectl delete pod <pod-name>
```

### 🔹 Delete a Deployment
```bash
kubectl delete deployment <deployment-name>
```

### 🔹 Delete a Service
```bash
kubectl delete svc <service-name>
```

### 🔹 Delete a Namespace
```bash
kubectl delete namespace <namespace>
```

---

## 🔹 Useful Shortcuts
| Command | Description |
|---------|-------------|
| `kubectl get all -A` | Get all resources in all namespaces |
| `kubectl get pods -o wide` | Show extra pod info (IPs, nodes) |
| `kubectl get svc -o wide` | Show extra service info |
| `kubectl delete pod --all` | Delete all pods in a namespace |
| `kubectl rollout status deployment/<deployment-name>` | Check rollout status |

---

## 🚀 Final Notes
- **Most used commands**: `get pods`, `get svc`, `logs`, `describe`
- **For debugging**: `logs`, `exec`, `events`
- **For managing services**: `get svc`, `describe svc`, `port-forward`
- **For deployments**: `edit deployment`, `rollout restart`, `delete deployment`

