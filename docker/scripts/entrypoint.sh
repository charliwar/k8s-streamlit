#!/bin/bash
git clone $REPOSITORY repo
pip install -r repo/requirements.txt
streamlit run --server.port 8501 repo/app.py