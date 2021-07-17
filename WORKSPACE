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

# third_party
load("//:repositories.bzl", "repositories")

repositories()

