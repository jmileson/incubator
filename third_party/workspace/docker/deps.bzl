load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")
load(
    "@io_bazel_rules_docker//python3:image.bzl",
    py_image_repos = "repositories",
)

def docker_deps():
    container_repositories()
    container_deps()
    py_image_repos()

