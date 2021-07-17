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

# Rust

## Install Rust

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

## Changing dependencies

Add, remove or update a dependency with `cargo-edit`

```
cd $(bazel info workspace)/third_party/cargo
cargo add my_dep
cargo rm other_dep
cargo upgrade third_dep
cargo generate-lockfile
```

Then run `cargo-raze` to generate `BUILD` files

```
$(bazel info workspace)/scripts/cargo-raze.sh
```

# Python
