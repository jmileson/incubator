load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

RULES_PYTHON_VERSION = "0.3.0"
RULES_PYTHON_SHA = "934c9ceb552e84577b0faf1e5a2f0450314985b4d8712b2b70717dc679fdc01b"

def python_repositories():
    maybe(
        http_archive,
        name = "rules_python",
        sha256 = RULES_PYTHON_SHA,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_python/releases/download/{}/rules_python-{}.tar.gz".format(RULES_PYTHON_VERSION, RULES_PYTHON_VERSION),
            "https://github.com/bazelbuild/rules_python/releases/download/{}/rules_python-{}.tar.gz".format(RULES_PYTHON_VERSION, RULES_PYTHON_VERSION),
        ],
    )


