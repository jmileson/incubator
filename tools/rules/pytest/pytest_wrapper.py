import os
import pytest
import sys

pytest_opts = []
bazel_working_dir = os.environ.get("BUILD_WORKING_DIRECTORY")
if bazel_working_dir:
    pytest_opts += ["--pstats-dir", os.path.join(bazel_working_dir, "prof")]

xml_output_file = os.environ.get("XML_OUTPUT_FILE")
if xml_output_file:
    pytest_opts += ["--junit-xml", xml_output_file]

test_target = os.environ.get("TEST_TARGET")
if test_target:
    pytest_opts += ["-o", "junit_suite_name={}".format(test_target)]

if __name__ == "__main__":
    args = sys.argv[1:] + pytest_opts
    print(f"args: `{args}`")
    sys.exit(pytest.main(args))
