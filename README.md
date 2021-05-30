This project contains the configuration needed to deploy multiple [streamlit.io](https://streamlit.io/) repository codes using the next kubernetes clusters:

- [EKS - Amazon Elastic Kubenetes Service](https://aws.amazon.com/es/eks/)

##### Run on Local
For testing purpose you can run on local in a Docker Container using the next command.
```
docker run -e "REPOSITORY=https://github.com/charliwardbd/streamlit-demo1.git" -e "APP_PATH=demo1" -p 8084:8501 charliwar/streamlit:1.4
```
and you can see the result  in http://localhost:8084.

You can see more options on [Docker Section](https://github.com/charliwardbd/k8s-streamlit/blob/master/docker/Dockerfile)