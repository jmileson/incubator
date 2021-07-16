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

# Changing dependencies

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
