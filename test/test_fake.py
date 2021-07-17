import sys
import platform


def test_fake():
    assert True
    assert "test.runfiles/python3/python3/bin/" in sys.executable
    assert platform.python_version() == "3.9.6"
