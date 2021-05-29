Reference 
https://aws.amazon.com/es/premiumsupport/knowledge-center/eks-access-kubernetes-services/



Versión de nginx ingress controller 1.10.1
https://github.com/nginxinc/kubernetes-ingress/tree/v1.10.1

- clonamos el repo 
git clone https://github.com/charliwardbd/k8s-streamlit

- Cambiamos de rama
git checkout multiservice

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
kubectl apply -f nginx-ingress.yaml
kubectl get pods --namespace=nginx-ingress


- Creamos load balancer
kubectl apply -f loadbalancer-aws-elb.yaml

kubectl get svc --namespace=nginx-ingress


- Actualizamos config map (Configure NGINX to use the PROXY protocol so that you can pass proxy information to the Ingress Controller, and add the following keys to the nginx-config.yaml file from step 1. For example:)

kubectl apply -f nginx-config-update.yaml

- Arrancamos los microservicios streamlit

kubectl apply -f streamlit-demo1-svc.yaml
kubectl apply -f streamlit-demo2-svc.yaml

- Creamos en route53 el dns para asociarlo al balanceador
anthonycornell.com.           A.    
ALIAS abf3d14967d6511e9903d12aa583c79b-e3b2965682e9fbde.elb.us-east-1.amazonaws.com 

- Implement Ingress so that it interfaces with your services using a single load balancer provided by Ingress Controller. See the following micro-ingress.yaml example:

kubectl apply -f path-ingress.yaml