"""Must be called after ./deps.bzl:python_deps, which is what generates @requirements."""

load("@requirements//:requirements.bzl", "install_deps")

def pip_install():
    install_deps()
