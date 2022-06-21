
### This repository is exmaple for setting up local kubernetes using k3d


#### Use below command to create k3d cluster, registry, namespace, build image, deployment, service and ingress.

```
k3d registry create k3d-registry --port 5050

k3d cluster create k3d-cluster -p "9900:80@loadbalancer" --registry-use k3d-k3d-registry:5050 --registry-config kubernetes/registries.yaml
./scripts/build.sh
kubectl create namespace flask
kubectl config set-context --current --namespace=flask
kubectl create deployment flask-web --image=k3d-k3d-registry:5050/flask-web:v1.0
kubectl get deployment flask-web -o yaml > kubernetes/flask-web.yaml
kubectl create service clusterip flask-web-service --tcp=80:5000
kubectl get service flask-web-service -o yaml > kubernetes/flask-web-service.yaml
kubectl apply -f ingress.yaml
```

