# Rust-Starter-Kit

## Description

This project is a boilerplate for projects in Rust.

## Step by step procedure

1. Clone the git repository
2. Remove the .git directory
3. Open Cargo.toml and change the project name for your new project
4. Remove the `LICENSE.md` file if needed
5. Change the `README.md` file using the provided template and remove `README.template.md`
6. Start coding: main files in src, test files in tests.

## Get started

### Remove the git directory

```bash
rm -rf .git
```

### Open Cargo.toml

```toml
[package]
name = "rust-starter-kit"
version = "0.1.0"
edition = "2021"
```

- Change the `name` field to the name of Gitlab repository including the group name for scoped packages.
- Change the `version` field to whatever you want, keeping the Semantic Versioning (see [SemVer](https://semver.org/) if you are not well versed in Semantic Versioning).
- Save your changes

#### Special procedure if using Nix

For you convenience and to simplify build dependencies and ensure consistency around your NixOS configuration, the project contains a flake to build and work in. It also contains a `direnv` configuration to bring forth the dependencies in your development shell provided by the flake.

You will need to change all the occurrences of `rust-starter-kit` in `flake.nix`:

```nix
packages = {
    # BOOTSTRAP: Replace "rust-starter-kit" with your package name
    rust-starter-kit = (rustPkgs.workspace.rust-starter-kit {}).bin;
    default = packages.rust-starter-kit;
    shell = devShells.default;
};
```

After your changes you need to update the `Cargo.nix` file using `cargo2nix`:

```bash
cargo build
cargo2nix
```

Additionally the flake provides a workspace shell to work in, you can update it by changes the associated function:

```nix
workspaceShell = (rustPkgs.workspaceShell {
    packages = [
        pkgs.rustup
        pkgs.rust-analyzer
        cargo2nixBin
    ];
    # shellHook = ''
    #   echo "In shell"
    # '';
}); # supports override & overrideAttrs
```

### Remove the LICENSE file

```bash
rm -rf LICENSE.md
```

### Change the README.md file

Obviously, you don't want to keep this file like this, you want to add the README of your own project. You can use the provided template to create your new README.

When you are done don't forget to remove the `README.template.md`

```bash
rm -rf README.template.md
```

### Start coding

Every source file should be in `src` directory and every test file in `tests/unit` directory.
