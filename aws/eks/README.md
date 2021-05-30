# EKS Deployment
Foldering with config for deploy [EKS - Amazon Elastic Kubenetes Service](https://aws.amazon.com/es/eks/) configured for deploy multiple [streamlit.io](https://streamlit.io/) specifying only repository of streamlit repository code.

This project enable de posibilities to deploy one EKS cluster with only one kubernetes ELB that discover many streamlit project as you need.

### Create and configure EKS Cluster
1. Create EC2 Instance

2. Connect to EC2 instance

3. Update and Configure Instance
		sudo yum update
		aws --version
		curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
		unzip awscliv2.zip
		which aws
		sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update
		aws --version
		sudo yum install -y git


4. Configure AWS CLI

		aws configure

    - With Project credentials
    - Zone : us-east-1
    - Output: json

5. Configure kubectl
		curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.20.4/2021-04-12/bin/linux/amd64/kubectl
		chmod +x ./kubectl
		mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
		kubectl version --short --client
		curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
		sudo mv /tmp/eksctl /usr/bin
		eksctl version

6. Create eks cluster
		eksctl create cluster --name dev --version 1.20 --region us-east-1 --nodegroup-name standard-workers --node-type t3.micro --nodes 3 --nodes-min 1 --nodes-max 4 --managed




### Deploying Services on Cluster

1. Clone repository
		git clone https://github.com/charliwardbd/k8s-streamlit && cd k8s-streamlit

2. Change branch
		git checkout multiservice

3. Create namespace
   		 kubectl apply -f aws/eks/multiservice/ns-and-sa.yaml

4. Create certificates
    		kubectl apply -f aws/eks/multiservice/default-server-secret.yaml

5. Create configmap for nginx configuration
		kubectl apply -f aws/eks/multiservice/nginx-config.yaml

6. Create roles for AWS perrmissions
		kubectl apply -f aws/eks/multiservice/rbac.yaml

7. Create IngressClaas (onli for cluster 1.18 or greater)
		kubectl apply -f aws/eks/multiservice/ingress-class.yaml

8. Create ingress controller
		kubectl apply -f aws/eks/multiservice/nginx-ingress.yaml
		kubectl get pods --namespace=nginx-ingress

9. Create ELB
		kubectl apply -f aws/eks/multiservice/loadbalancer-aws-elb.yaml

		kubectl get svc --namespace=nginx-ingress

10. Update config map (Configure NGINX to use the PROXY protocol so that you can pass proxy information to the Ingress Controller, and add the following keys to the nginx-config.yaml file from step 1. For example:)
		kubectl apply -f aws/eks/multiservice/nginx-config-update.yaml

11. Create microservice applying deploy and service
		kubectl apply -f aws/eks/multiservice/streamlit-demo1-svc.yaml
		kubectl apply -f aws/eks/multiservice/streamlit-demo2-svc.yaml

12. Create on route53 the alias assocciated tu ELB created
		hostname.mydomain.com.           A.    ALIAS abfxxxxxxxdXXXXXx990XXXXXxxxxxx-e3bxXXX9xXXXx.elb.us-east-1.amazonaws.com 

13. Implement Ingress so that it interfaces with your services using a single load balancer provided by Ingress Controller. 
		kubectl apply -f path-ingress.yaml



References
https://aws.amazon.com/es/premiumsupport/knowledge-center/eks-access-kubernetes-services/