#!/bin/bash
git clone $REPOSITORY repo
pip install -r repo/requirements.txt
streamlit run repo/app.py --server.baseUrlPath=$APP_PATH
