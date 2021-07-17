load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

CURL_VERSION = "7.74.0"

def curl_repositories():
    maybe(
        http_archive,
        name = "curl",
        urls = [
            "https://curl.se/download/curl-{}.tar.gz".format(CURL_VERSION),
            "https://github.com/curl/curl/releases/download/curl-{}/curl-{}.tar.gz".format(CURL_VERSION.replace(".", "_"), CURL_VERSION),
        ],
        type = "tar.gz",
        sha256 = "e56b3921eeb7a2951959c02db0912b5fcd5fdba5aca071da819e1accf338bbd7",
        strip_prefix = "curl-{}".format(CURL_VERSION),
        build_file = Label("//third_party/curl:BUILD.curl.bazel"),
    )
