#!/bin/sh
cd $(bazel info workspace)
bazel run --sandbox_debug @cargo_raze//:raze -- --manifest-path=$(realpath third_party/cargo/Cargo.toml)
