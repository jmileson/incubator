load("@rules_python//python:repositories.bzl", "python_register_toolchains")


def python_interpreter(version):
    python_register_toolchains(
        name = "python3",
        python_version = version,
    )
