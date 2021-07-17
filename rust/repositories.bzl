load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def rust_repositories():
    maybe(
        http_archive,
        name = "rules_rust",
        sha256 = "224ebaf1156b6f2d3680e5b8c25191e71483214957dfecd25d0f29b2f283283b",
        strip_prefix = "rules_rust-a814d859845c420fd105c629134c4a4cb47ba3f8",
        urls = [
            # `main` branch as of 2021-06-15
            "https://github.com/bazelbuild/rules_rust/archive/a814d859845c420fd105c629134c4a4cb47ba3f8.tar.gz",
        ],
    )

    


