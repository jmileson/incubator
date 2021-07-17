"""Wrap pytest"""

load("@rules_python//python:defs.bzl", "py_test")
load("@requirements//:requirements.bzl", "requirement")

def pytest_test(name, srcs, coverage, deps = [], args = [], data = [], **kwargs):
    """Call pytest"""
    py_test(
        name = name,
        srcs = [
            "//tools/rules/pytest:pytest_wrapper.py",
        ] + srcs,
        main = "//tools/rules/pytest:pytest_wrapper.py",
        args = [
            "--capture=no",
            "-c=$(location //tools/python:setup.cfg)",
            "--black",
            "--flake8",
            "--mypy",
            "-r",
            "a",
            "-q",
            "--cov",
            coverage,
            "--cov-branch",
            "-p", 
            "no:warnings", 
            "-p", 
            "no:cacheprovider",
        ] + args + ["$(location :%s)" % x for x in srcs],
        python_version = "PY3",
        srcs_version = "PY3",
        deps = deps + [
            requirement("pytest"),
            requirement("pytest-black"),
            requirement("pytest-cov"),
            requirement("pytest-flake8"),
            requirement("pytest-mypy"),
        ],
        data = [
            "//tools/python:setup.cfg",
        ] + data,
        **kwargs
    )
