workspace(name = "projects")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

############
# EXTERNAL #
############

# RULES_FOREIGN_CC
load("//third_party/workspace/foreign_cc:repositories.bzl", "foreign_cc_repositories")
foreign_cc_repositories()

load("//third_party/workspace/foreign_cc:deps.bzl", "foreign_cc_deps")
foreign_cc_deps()

###################
# LANGUAGE CONFIG #
###################

# GOLANG
load("//third_party/workspace/golang:repositories.bzl", "golang_repositories")
golang_repositories()

load("//third_party/workspace/golang:deps.bzl", "golang_deps")
golang_deps("1.16.6")

load("//third_party/golang:deps.bzl", "go_deps")

# gazelle:repository_macro third_party/golang/deps.bzl%go_deps
go_deps()

# PYTHON
load("//third_party/workspace/python:repositories.bzl", "python_repositories")
python_repositories()

# RUST
load("//third_party/workspace/rust:repositories.bzl", "rust_repositories")
rust_repositories()

load("//third_party/workspace/rust:deps.bzl", "rust_deps")
rust_deps("2021-07-15")

# third_party
load("//third_party/workspace:repositories.bzl", "repositories")
repositories()

# PIP
# this is deferred after third_party so that we register the
# compiled python toolchain prior to resolving the dependencies
load("//third_party/workspace/python:deps.bzl", "python_deps")
python_deps()

load("//third_party/workspace/python:pip_install.bzl", "pip_install")
pip_install()

##########
# DOCKER #
##########

load("//third_party/workspace/docker:repositories.bzl", "docker_repositories")
docker_repositories()

load("//third_party/workspace/docker:deps.bzl", "docker_deps")
docker_deps()
