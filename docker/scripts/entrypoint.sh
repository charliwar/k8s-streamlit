#!/bin/bash
git clone $REPOSITORY repo
pip install -r repo/requirements.txt
streamlit run repo/app.py