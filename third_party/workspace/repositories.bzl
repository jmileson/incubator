load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

rules_python_version = "0.9.0"
rules_python_sha256 = "5fa3c738d33acca3b97622a13a741129f67ef43f5fdfcec63b29374cc0574c29"

rules_rust_version = "4e8e7e1e4a844c57d49b10b1c52ba3338a4ec98a"
rules_rust_sha256 = ""

rules_go_version = "0.33.0"
rules_go_sha256 = "685052b498b6ddfe562ca7a97736741d87916fe536623afb7da2824c0211c369"

gazelle_version = "0.26.0"
gazelle_sha256 = "501deb3d5695ab658e82f6f6f549ba681ea3ca2a5fb7911154b5aa45596183fa"

rules_docker_version = "0.25.0"
rules_docker_sha256 = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf"

def repositories():
    """
    Load repositories needed for rules, etc.
    """
    http_archive(
        name = "rules_rust",
        sha256 = rules_rust_sha256,
        strip_prefix = "rules_rust-{}".format(rules_rust_version),
        urls = [
            "https://github.com/bazelbuild/rules_rust/archive/{}.tar.gz".format(rules_rust_version),
        ],
    )

    http_archive(
        name = "rules_python",
        sha256 = rules_python_sha256,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_python/releases/download/{0}/rules_python-{0}.tar.gz".format(rules_python_version),
            "https://github.com/bazelbuild/rules_python/releases/download/{0}/rules_python-{0}.tar.gz".format(rules_python_version),
        ],
    )

    http_archive(
        name = "io_bazel_rules_go",
        sha256 = rules_go_sha256,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v{0}/rules_go-v{0}.zip".format(rules_go_version),
            "https://github.com/bazelbuild/rules_go/releases/download/v{0}/rules_go-v{0}.zip".format(rules_go_version),
        ],
    )

    http_archive(
        name = "bazel_gazelle",
        sha256 = gazelle_sha256,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(gazelle_version),
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(gazelle_version),
        ],
    )

    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = rules_docker_sha256,
        strip_prefix = "rules_docker-{}".format(rules_docker_version),
        urls = [
            "https://github.com/bazelbuild/rules_docker/releases/download/v{0}/rules_docker-v{0}.tar.gz".format(rules_docker_version),
        ],
    )
