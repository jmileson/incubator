load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")


def foreign_cc_repositories():
    maybe(
        http_archive,
        name = "rules_foreign_cc",
        sha256 = "e14a159c452a68a97a7c59fa458033cc91edb8224516295b047a95555140af5f",
        strip_prefix = "rules_foreign_cc-0.4.0",
        urls = [
            "https://github.com/bazelbuild/rules_foreign_cc/archive/0.4.0.tar.gz",
        ]
    )

    # load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

    # This sets up some common toolchains for building targets. For more details, please see
    # https://bazelbuild.github.io/rules_foreign_cc/0.4.0/flatten.html#rules_foreign_cc_dependencies
    # rules_foreign_cc_dependencies(register_preinstalled_tools = False)


