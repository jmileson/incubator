load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

LIBSSH2_VERSION = "1.9.0"

def libssh2_repositories():
    maybe(
        http_archive,
        name = "libssh2",
        urls = [
            "https://github.com/libssh2/libssh2/releases/download/libssh2-{}/libssh2-{}.tar.gz".format(LIBSSH2_VERSION, LIBSSH2_VERSION),
        ],
        type = "tar.gz",
        sha256 = "d5fb8bd563305fd1074dda90bd053fb2d29fc4bce048d182f96eaa466dfadafd",
        strip_prefix = "libssh2-{}".format(LIBSSH2_VERSION),
        build_file = Label("//third_party/external/libssh2:BUILD.libssh2.bazel"),
    )
