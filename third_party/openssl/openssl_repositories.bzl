load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

OPENSSL_VERSION = "1.1.1h"

def openssl_repositories():
    maybe(
        http_archive,
        name = "openssl",
        build_file = Label("//third_party/openssl:BUILD.openssl.bazel"),
        sha256 = "5c9ca8774bd7b03e5784f26ae9e9e6d749c9da2438545077e6b3d755a06595d9",
        strip_prefix = "openssl-{}".format(OPENSSL_VERSION),
        urls = [
            "https://www.openssl.org/source/openssl-{}.tar.gz".format(OPENSSL_VERSION),
            "https://github.com/openssl/openssl/archive/OpenSSL_{}.tar.gz".format(OPENSSL_VERSION.replace(".", "_")),
        ],
    )
