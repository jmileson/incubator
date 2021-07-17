#!/bin/sh
cd $(bazelisk info workspace)/third_party/cargo
cargo raze
