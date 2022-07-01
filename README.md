# Overview

`incubator` is a place to start new projects.

## Project structure

```

├── cmd             - Go binaries
├── crates          - Cargo workspace Crates
├── incubator       - Python packages root namespace
│   ├── <appname>   - Python applications have their own directories
│   └── common      - Python common libraries nested here
├── pkg             - Go packages
├── scripts         - Place to put build/helper/miscellaneous scripts
├── third_party     - Package for managing third-party resources
│   ├── cargo       - Rust's Cargo config
│   ├── golang      - Golang's packaging config
│   ├── python      - Python's packaging config
│   └── workspace   - Place to put repository rules, to keep WORKSPACE cleaner
└── tools           - Place to put tools for this workspace
    ├── python      - Python tooling config
    └── rules       - Custom rules for this workspace
```

# Language Support

Bazel provides toolchains for compiling and running code for different languages,
however, to make your editor happy, you may need to install toolchains on your machine.

Use `asdf` to do this:

```
asdf plugin add python
asdf plugin add golang
asdf plugin add rust
asdf plugin add nodejs
asdf install
```

You may also want to install [`direnv`](https://direnv.net/) and run

```
direnv allow
```

To add workspace-specific helper scripts to your path when working in this workspace.

## Go

Add, remove or update a dependency with `go get`

```
go get github.com/example/foo
go mod tidy
```

Then run

```
bazel run //:gazelle_update_repos
```

## Python

Add, remove or update a dependency in `requirements.in`

```
vim $(bazelisk info workspace)/requirents.in
```

Then run the update script to compile `requirements_lock.txt` and install the requirements
into your current Python environment.

```
update-python-deps
```

## Rust

Install `cargo-edit` to make life a little easier:

```
cargo install cargo-edit
```

### Changing dependencies

Add, remove or update a dependency with `cargo-edit`

```
cd crates/my_crate
cargo-add my_dep
cargo-rm other_dep
cargo-upgrade third_dep
```

Using these scripts will update the Cargo.lock and generate bazel macros
for the Cargo dependencies.

For the moment, the Cargo workspace can't specify the dependencies to inherit,
but work around this [is happening](https://github.com/rust-lang/cargo/issues/8415)
and that's really exciting.
