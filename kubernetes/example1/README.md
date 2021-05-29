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