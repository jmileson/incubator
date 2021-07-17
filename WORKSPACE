workspace(name = "projects")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# RULES_FOREIGN_CC
load("//foreign_cc:repositories.bzl", "foreign_cc_repositories")
foreign_cc_repositories()

load("//foreign_cc:deps.bzl", "foreign_cc_deps")
foreign_cc_deps()

# RUST
load("//rust:repositories.bzl", "rust_repositories")
rust_repositories()

load("//rust:deps.bzl", "rust_deps")
rust_deps("2021-07-15")

# PYTHON
load("//python:repositories.bzl", "python_repositories")
python_repositories()

# third_party
load("//:repositories.bzl", "repositories")

repositories()

# PIP
# this is deferred after third_party so that we register the
# compiled python toolchain prior to resolving the dependencies
load("//python:deps.bzl", "python_deps")
python_deps()

load("//python:pip_install.bzl", "pip_install")
pip_install()


