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

    
