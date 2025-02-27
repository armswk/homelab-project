in order to route traffic to traefik their are some requiement file
- deployment.yaml
- ingress.yaml
- service.yaml

## Deploment
this zone has to be configure and the value of the metadata name should be the same of the rest YAML file
metadata:
  name: nginx
  namespace: default
  labels:
    app: nginx

## Ingress
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: nginx
  namespace: default
  annotations: 
    kubernetes.io/ingress.class: traefik-external
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`URL.local.narybits.site`)
      kind: Rule
      services:
        - name: nginx
          port: 80
      middlewares:
        - name: default-headers
  tls:
    secretName: local-narybits-site-tls

## Service
apiVersion: v1
kind: Service
metadata:
  name: nginx
  namespace: default
spec:
  selector:
    app: nginx
  ports:
  - name: http
    targetPort: 80
    port: 80