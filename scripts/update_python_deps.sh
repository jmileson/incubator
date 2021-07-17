#!/usr/bin/env bash
cd $(bazel info workspace)/third_party/python
pip-compile --generate-hashes --allow-unsafe

if [[ -n "${VIRTUAL_ENV}" ]]; then
  # update virtualenv only
  pip install -r requirements.txt
fi
