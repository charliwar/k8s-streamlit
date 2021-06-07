# GKE Deployment
- Create Compute Engine Instance

- Generate SSH KEY
  ssh-keygen -t rsa
  ssh-keygen -y -f gke > gke.pub

- Add key on metadata of Compute Enginde
    Compute-Engine --> Metadada --> SSH keys

- Enable API GKE

- Create GKE Cluster

gcloud beta container --project "<PROJECT_NAME>" clusters create "dev-cluster" --zone "us-central1-c" --no-enable-basic-auth --cluster-version "1.19.9-gke.1400" --release-channel "regular" --machine-type "n1-standard-1" --image-type "COS_CONTAINERD" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "3" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/<PROJECT_NAME>/global/networks/default" --subnetwork "projects/<PROJECT_NAME>/regions/us-central1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-shielded-nodes --node-locations "us-central1-c"


- Install kubectl on created instance
sudo apt-get install kubectl

- Configure the access to the control plane on the instance
gcloud container clusters get-credentials <CLUSTER_NAME> --zone us-central1-c --project <PROJECT_NAME>

- Give Owner permissions to GKE for enable create roles on cluster. 
    Give Owner on Identity Service


### Deploying Services on Cluster with HELM

- Install helm 
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

- Install git 
sudo apt-get install git

- Clone repository
git clone https://github.com/charliwardbd/k8s-streamlit && cd k8s-streamlit


- Añadimos repo de helm
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update

- Deploy an NGINX controller Deployment and (LoadBalancer) Service by running the following command:

helm install nginx-ingress nginx-stable/nginx-ingress

kubectl get deployment nginx-ingress-nginx-ingress
kubectl get service nginx-ingress-nginx-ingress

- Deploy pods and services
```
kubectl apply -f streamlit-demo1-svc.yaml
kubectl apply -f streamlit-demo2-svc.yaml
```

- Create ingress resources used by nginx controller

kubectl apply -f path-ingress.yaml


References
https://cloud.google.com/community/tutorials/nginx-ingress-gke