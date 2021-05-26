# k8s-streamlit
docker build --tag 'streamlit' .

docker run -e "REPOSITORY=https://github.com/charliwardbd/streamlit-demo1.git" -p 8082:8501 k8s-streamlit -ti bash

- Create User
Save credentials

- Create EC2 Instance
Save credentials

- Connect to EC2 instance

- Update
sudo yum update
aws --version
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
which aws
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update
aws --version

- Configure AWS services

aws configure
    - Credentials saved
    - us-east-1
    - json 

sudo yum install -y git
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
kubectl version --short --client
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/bin
eksctl version
eksctl create cluster --name dev --version 1.16 --region us-east-1 --nodegroup-name standard-workers --node-type t3.micro --nodes 3 --nodes-min 1 --nodes-max 4 --managed

- Clone repository
git clone https://github.com/charliwardbd/k8s-streamlit

- Apply services an deployment 
kubectl apply -f ./streamlit-deployment.yaml

kubectl apply -f ./streamlit-svc.yaml


kubectl create configmap confnginx --from-file=nginx.conf

kubectl apply -f ./nginx-deployment.yaml

kubectl apply -f ./nginx-svc.yaml



kubectl delete configmap confnginx

kubectl delete deployment nginx-deployment




---------------------------------------------------------------------------------------------------------------------------
Reference 
https://aws.amazon.com/es/premiumsupport/knowledge-center/eks-access-kubernetes-services/


Versión de nginx ingress controller 1.10.1
https://github.com/nginxinc/kubernetes-ingress/tree/v1.10.1

- Creamos el namespace
    kubectl apply -f ns-and-sa.yaml

- Creamos certificados
    kubectl apply -f default-server-secret.yaml

- Creamos configmap para la configuracion de NGINX
kubectl apply -f nginx-config.yaml

- Creamos el cluster role para los permisos en AWS
kubectl apply -f rbac.yaml

- Creamos ingress class (para cluster igual o superior a 1.18)
kubectl apply -f ingress-class.yaml

- Desplegamos ingress controller
kubectl apply -f deployment/nginx-ingress.yaml
kubectl get pods --namespace=nginx-ingress


- Creamos load balancer
kubectl apply -f service/loadbalancer-aws-elb.yaml

kubectl get svc --namespace=nginx-ingress


- Actualizamos config map (Configure NGINX to use the PROXY protocol so that you can pass proxy information to the Ingress Controller, and add the following keys to the nginx-config.yaml file from step 1. For example:)

- Arrancamos los microservicios streamlit
kubectl apply -f streamlit-demo1-svc.yaml
kubectl apply -f streamlit-demo2-svc.yaml

- Implement Ingress so that it interfaces with your services using a single load balancer provided by Ingress Controller. See the following micro-ingress.yaml example:

kubectl apply -f micro-ingress.yaml


kubectl apply -f path-ingress.yaml
