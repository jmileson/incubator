#!/usr/bin/env bash
cd $(bazel info workspace)
bazel run //:gazelle -- update-repos \
  -from_file=go.mod \
  -to_macro=third_party/golang/deps.bzl%go_deps
