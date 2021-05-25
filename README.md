# k8s-streamlit
docker build --tag 'k8s-streamlit' .

docker run -e "REPOSITORY=https://github.com/charliwardbd/streamlit-demo1.git" -p 8080:8501 k8s-streamlit -ti bash