#!/bin/sh
cd $(bazel info workspace)
pip-compile --generate-hashes --allow-unsafe

pip install -r requirements.txt
