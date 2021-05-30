The intention of this repo it's enable to deploy repo with Streamlit Code in a configurable docker container

# Prerrequisites
Repository with app developed using [streamlit.io](https://streamlit.io/)

To work correctly the repo must be contain 
     - app.py (main file for run)
     - requirements (file for requirements needed in the app)

You can use the next two examples
      - [DEMO1](https://github.com/charliwardbd/streamlit-demo1.git)
      - [DEMO2](https://github.com/charliwardbd/streamlit-demo2.git)

## Run image
```
docker run -e "REPOSITORY=https://github.com/charliwardbd/streamlit-demo1.git" -e "APP_PATH=demo1" -p 8084:8501 charliwar/streamlit:1.4
```
http://localhost:8084/demo1

| VAR           | VALUE         | Description  |
| ------------- |:-------------:| -----:|
| REPOSITORY    | String        | Path of git repository to deploy |
| APP_PATH      | String        | Route where service will be deployed |



## Build Image
```
docker build --tag 'streamlit' .
```


