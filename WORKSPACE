workspace(name = "incubator")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

######################
# RULES REPOSITORIES #
######################

load("//third_party/workspace:repositories.bzl", "repositories")
repositories()

###################
# LANGUAGE CONFIG #
###################

golang_version = "1.18.3"
rust_version = "2022-07-01"
python_version = "3.10"

# GOLANG
load("//third_party/workspace/golang:deps.bzl", "golang_deps")
golang_deps(golang_version)

load("//third_party:go_deps.bzl", "go_deps")

# gazelle:repository_macro third_party/go_deps.bzl%go_deps
go_deps()

# PYTHON
load("//third_party/workspace/python:interpreter.bzl", "python_interpreter")
python_interpreter(python_version)

load("//third_party/workspace/python:deps.bzl", "python_deps")
python_deps()

load("//third_party/workspace/python:pip_install.bzl", "pip_install")
pip_install()

# RUST
load("//third_party/workspace/rust:deps.bzl", "rust_deps")
rust_deps(rust_version)

##########
# DOCKER #
##########

load("//third_party/workspace/docker:deps.bzl", "docker_deps")
docker_deps()
