# Overview

`incubator` is a place to start new projects.

## Project structure

```
├── incubator       - Package for all code
│   └── common      - Package to put common code
├── scripts         - Place to put build/helper/miscellaneous scripts
├── third_party     - Package for managing third-party resources
│   ├── cargo       - Rust's Cargo config
│   ├── external    - Package for building external dependencies
│   ├── golane      - Golang's packaging config
│   ├── python      - Python's packaging config
│   └── workspace   - Place to put repository rules, to keep WORKSPACE cleaner
└── tools           - Place to put tools for this workspace
    ├── python      - Python tooling config
    └── rules       - Custom rules for this workspace
```

# Language Support

## Go

### Changing dependencies

## Python

Python 2.7 and Python 3.9 interpreters are vendored in `//third_party/external/python` and registered as toolchains.
In general only Python 3.9 is configured and usable - the Python 2.7 interpreter is just a proof of concept at the moment.

### Changing dependencies

Add, remove or update a dependency in `requirements.in`

```
vim $(bazelisk info workspace)/third_party/python/requirents.in
```

Then run the update script to compile `requirements.txt`

```
$(bazel info workspace)/scrpts/update_python_deps.sh
```

If you have a `virtualenv` activated (`VIRTUAL_ENV` is set in the environment), the update script
will also install the requirements generated into `requirements.txt` into your `virtualenv`.

## Rust

### Install Rust

Installing Rust on your machine makes life easier, since you can use `cargo` to help with packaging.

Install `rustup`:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Then install the version of Rust specified in `WORKSPACE` (currently `nightly-2021-07-15`):

```
rustup update nightly-2021-07-15
```

Also install `cargo-edit` to make life a little easier:

```
cargo install cargo-edit
```

### Changing dependencies

Add, remove or update a dependency with `cargo-edit`

```
cd $(bazelisk info workspace)/third_party/cargo
cargo add my_dep
cargo rm other_dep
cargo upgrade third_dep
cargo generate-lockfile
```

Then run `cargo-raze` to generate `BUILD` files

```
$(bazel info workspace)/scripts/cargo-raze.sh
```

### Rust Analyzer supportkitty [debug config](--debug-config)

When adding new Rust targets, you need to update the Rust analyzer settings in `BUILD.bazel` by adding the output of `bazel query 'kind("rust_*library|rust_binary", //...:all)'` to the `targets`.
