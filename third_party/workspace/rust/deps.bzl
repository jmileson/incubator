load("@rules_rust//rust:repositories.bzl", "rust_repositories")
load("@rules_rust//tools/rust_analyzer:deps.bzl", "rust_analyzer_deps")


def rust_deps(iso_date):
    rust_repositories(version = "nightly", iso_date = iso_date, edition = "2021")

    # Rust Analyzer
    rust_analyzer_deps()


