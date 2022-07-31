
### This repository is exmaple for setting up local kubernetes using k3d


#### Use below command to create k3d cluster, registry without default loadbalance (traefik)

```
k3d registry create k3d-registry --port 5050
k3d cluster create ak-cluster -p "9900:80@loadbalancer" --registry-use k3d-k3d-registry:5050 --registry-config kubernetes/k3d-registries.yaml --k3s-arg "--no-deploy=traefik@server:*"
```

#### Create a loadbalance ingress-nginx

```
kubectl apply -f kubernetes/k3d-ingress-nginx.yaml
```

#### Create a namespace, build image, deployment, service and ingress.

```
kubectl create namespace flask
kubectl config set-context --current --namespace=flask
./scripts/build.sh
```




#### Use Existing deployments.

```
kubectl apply -f kubernetes/flask-web.yaml
kubectl apply -f kubernetes/flask-web-service.yaml
kubectl apply -f kubernetes/ingress.yaml
```

#### Create and save new deployments

kubectl create deployment flask-web --image=k3d-k3d-registry:5050/flask-web:v1.0
kubectl get deployment flask-web -o yaml > kubernetes/flask-web.yaml
kubectl create service clusterip flask-web-service --tcp=80:5000
kubectl get service flask-web-service -o yaml > kubernetes/flask-web-service.yaml
```

