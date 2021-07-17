load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

ZLIB_VERSION = "1.2.11"

def zlib_repositories():
    maybe(
        http_archive,
        name = "zlib",
        build_file = Label("//third_party/external/zlib:BUILD.zlib.bazel"),
        sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
        strip_prefix = "zlib-{}".format(ZLIB_VERSION),
        urls = [
            "https://zlib.net/zlib-{}.tar.gz".format(ZLIB_VERSION),
            "https://storage.googleapis.com/mirror.tensorflow.org/zlib.net/zlib-{}.tar.gz".format(ZLIB_VERSION),
        ],
    )
