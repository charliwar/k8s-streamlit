# EKS Deployment
Foldering with config for deploy [EKS - Amazon Elastic Kubenetes Service](https://aws.amazon.com/es/eks/) configured for deploy multiple [streamlit.io](https://streamlit.io/) project specifying only repository of streamlit repository code.

With this config you can enable the possibility to deploy one EKS cluster with only one kubernetes ELB that discover multiples [streamlit.io](https://streamlit.io/) projects as you need.

![Diagram](https://github.com/charliwardbd/k8s-streamlit/blob/aws/eks/EKS-diagram.png)



### Create and configure EKS Cluster
1. Create EC2 Instance

2. Connect to EC2 instance

3. Update and Configure Instance
```
sudo yum update
aws --version
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
which aws
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update
aws --version
sudo yum install -y git
```


4. Configure AWS CLI
```
aws configure
```
    - With Project credentials
    - Zone : us-east-1
    - Output: json

5. Configure kubectl
```
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.20.4/2021-04-12/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
kubectl version --short --client
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/bin
eksctl version
```

6. Create eks cluster
```
eksctl create cluster --name dev --version 1.20 --region us-east-1 --nodegroup-name standard-workers --node-type t3.micro --nodes 3 --nodes-min 1 --nodes-max 4 --managed
```



### Deploying Services on Cluster

1. Clone repository
```
git clone https://github.com/charliwardbd/k8s-streamlit && cd k8s-streamlit
```

2. Create namespace
```
kubectl apply -f aws/eks/ns-and-sa.yaml
```

3. Create certificates
```
kubectl apply -f aws/eks/default-server-secret.yaml
```

4. Create configmap for nginx configuration
```
kubectl apply -f aws/eks/nginx-config.yaml
```

5. Create roles EKS perrmissions
```
kubectl apply -f aws/eks/rbac.yaml
```

6. Create IngressClaas (only for cluster 1.18 or greater)
```
kubectl apply -f aws/eks/ingress-class.yaml
```

7. Create ingress controller
```
kubectl apply -f aws/eks/nginx-ingress.yaml
kubectl get pods --namespace=nginx-ingress
```

8. Create ELB
```
kubectl apply -f aws/eks/loadbalancer-aws-elb.yaml

kubectl get svc --namespace=nginx-ingress
```

9. Update config map (Configure NGINX to use the PROXY protocol so that you can pass proxy information to the Ingress Controller, and add the following keys to the nginx-config.yaml file from step 1. For example:)
```
kubectl apply -f aws/eks/nginx-config-update.yaml
```

10. Create microservice applying deploy and service
```
kubectl apply -f aws/eks/streamlit-demo1-svc.yaml
kubectl apply -f aws/eks/streamlit-demo2-svc.yaml
```

11. Create on route53 the alias assocciated to created ELB
```
hostname.mydomain.com.           A.    ALIAS abfxxxxxxxdXXXXXx990XXXXXxxxxxx-e3bxXXX9xXXXx.elb.us-east-1.amazonaws.com 
```
12. Implement Ingress so that it interfaces with your services using a single load balancer provided by Ingress Controller. 
```
kubectl apply -f path-ingress.yaml
```

#### Deploying Services on Cluster

For testing you can go to the navigator and put the URL of your load balancer if you put this url on path-ingress.yaml in host

```
.........
		- host: hostname.mydomain.com (or ELB load balancer url )
        http:
        	paths:
            - path: /demo1
........
```

Or you can put the ELB url in navigator passing the header " Host : hostname.mydomain.com"




References
https://aws.amazon.com/es/premiumsupport/knowledge-center/eks-access-kubernetes-services/