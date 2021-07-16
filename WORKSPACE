load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# RUST

http_archive(
    name = "rules_rust",
    sha256 = "224ebaf1156b6f2d3680e5b8c25191e71483214957dfecd25d0f29b2f283283b",
    strip_prefix = "rules_rust-a814d859845c420fd105c629134c4a4cb47ba3f8",
    urls = [
        # `main` branch as of 2021-06-15
        "https://github.com/bazelbuild/rules_rust/archive/a814d859845c420fd105c629134c4a4cb47ba3f8.tar.gz",
    ],
)

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories(version = "nightly", iso_date = "2021-07-15", edition = "2018")

# Rust Analyzer
load("@rules_rust//tools/rust_analyzer:deps.bzl", "rust_analyzer_deps")

rust_analyzer_deps()

# Cargo Raze
http_archive(
    name = "cargo_raze",
    sha256 = "0a7986b1a8ec965ee7aa317ac61e82ea08568cfdf36b7ccc4dd3d1aff3b36e0b",
    strip_prefix = "cargo-raze-0.12.0",
    url = "https://github.com/google/cargo-raze/archive/refs/tags/v0.12.0.tar.gz",
)

load("@cargo_raze//:repositories.bzl", "cargo_raze_repositories")

cargo_raze_repositories()

load("@cargo_raze//:transitive_deps.bzl", "cargo_raze_transitive_deps")

cargo_raze_transitive_deps()

