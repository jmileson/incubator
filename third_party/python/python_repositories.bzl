load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# buildifier: disable=unnamed-macro

def _python_repository(name, version, sha):
    maybe(
        http_archive,
        name = name,
        build_file = Label("//third_party/python:BUILD.{}.bazel".format(name)),
        strip_prefix = "Python-{}".format(version),
        urls = [
            "https://www.python.org/ftp/python/{}/Python-{}.tgz".format(version, version),
        ],
        sha256 = sha,
    )

PYTHON2_VERSION = "2.7.18"
PYTHON2_SHA = "da3080e3b488f648a3d7a4560ddee895284c3380b11d6de75edb986526b9a814"
PYTHON3_VERSION = "3.9.6"
PYTHON3_SHA = "d0a35182e19e416fc8eae25a3dcd4d02d4997333e4ad1f2eee6010aadc3fe866"
RULES_PYTHON_VERSION = "0.3.0"
RULES_PYTHON_SHA = "934c9ceb552e84577b0faf1e5a2f0450314985b4d8712b2b70717dc679fdc01b"

def python_repositories():
    _python_repository("python2", PYTHON2_VERSION, PYTHON2_SHA)
    _python_repository("python3", PYTHON3_VERSION, PYTHON3_SHA)

    maybe(
        http_archive,
        name = "rules_python",
        sha256 = RULES_PYTHON_SHA,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_python/releases/download/{}/rules_python-{}.tar.gz".format(RULES_PYTHON_VERSION, RULES_PYTHON_VERSION),
            "https://github.com/bazelbuild/rules_python/releases/download/{}/rules_python-{}.tar.gz".format(RULES_PYTHON_VERSION, RULES_PYTHON_VERSION),
        ],
    )

    native.register_toolchains("@projects//third_party/python:python_toolchain")
