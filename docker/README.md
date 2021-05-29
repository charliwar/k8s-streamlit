docker build --tag 'streamlit' .

docker run -e "REPOSITORY=https://github.com/charliwardbd/streamlit-demo1.git" -p 8082:8501 k8s-streamlit -ti bash