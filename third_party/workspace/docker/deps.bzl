load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")
load(
    "@io_bazel_rules_docker//python3:image.bzl",
    py_image_repos = "repositories",
)
load(
    "@io_bazel_rules_docker//go:image.bzl",
    go_image_repos = "repositories",
)
load(
    "@io_bazel_rules_docker//rust:image.bzl",
    rust_image_repos = "repositories",
)

def docker_deps():
    container_repositories()
    container_deps()

    # language repos
    py_image_repos()
    go_image_repos()
    rust_image_repos()
