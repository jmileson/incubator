load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//third_party/external/curl:curl_repositories.bzl", "curl_repositories")
load("//third_party/external/libssh2:libssh2_repositories.bzl", "libssh2_repositories")
load("//third_party/external/openssl:openssl_repositories.bzl", "openssl_repositories")
load("//third_party/external/python:python_repositories.bzl", "python_repositories")
load("//third_party/external/zlib:zlib_repositories.bzl", "zlib_repositories")

# buildifier: disable=unnamed-macro
def repositories():
    """Load all repositories needed for the targets of rules_foreign_cc_examples_third_party"""
    openssl_repositories()
    curl_repositories()
    libssh2_repositories()
    zlib_repositories()
    python_repositories()
