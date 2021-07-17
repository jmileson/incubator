load("@rules_python//python:pip.bzl", "pip_parse")


def python_deps():
    pip_parse(
       name = "requirements",
       requirements_lock = "//third_party/python:requirements.txt",
    )
