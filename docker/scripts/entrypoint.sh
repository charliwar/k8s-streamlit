#!/bin/bash
git clone $REPOSITORY repo
pip install -r repo/requirements.txt
streamlit run repo/app.py --global.logLevel=debug --server.baseUrlPath=$APP_PATH
