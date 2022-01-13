# Welcome to the golden smalltalk template

[![CI-linux](https://github.com/nokx5/golden-smalltalk/workflows/CI-linux/badge.svg)](https://github.com/nokx5/golden-smalltalk/actions/workflows/ci-linux.yml) [![CI-linux](https://github.com/nokx5/golden-smalltalk/workflows/CI-darwin/badge.svg)](https://github.com/nokx5/golden-smalltalk/actions/workflows/ci-darwin.yml) [![doc](https://github.com/nokx5/golden-smalltalk/workflows/doc-api/badge.svg)](https://nokx5.github.io/golden-smalltalk) [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nokx5/golden-smalltalk/blob/master/LICENSE)

This is a skeleton template for a C/C++ project. Please find all the documentation [here](https://nokx5.github.io/golden-smalltalk) and the source code [here](https://github.com/nokx5/golden-smalltalk).

> **NOTE:** you may require the experimental flakes commands `nix build` and `nix shell` in the following. If you do not, only classic nix commands `nix-build` and `nix-shell` will be available.

## My development tools are
- nix :snowflake: (packaging from hell :heart:)
- clang-format (formatter)
- vscode (IDE) with
  - llvm-vs-code-extensions.vscode-clangd
  - ms-vscode.cmake-tools
  - ms-vscode.smalltalktools
- ctest (unit testing)
- markdown (documentation)


## Use the software

> The channel will be locked by the flake in future nix releases. The following command would probably not be allowed anymore soon.
> ```bash
> nix-shell --version # before 2.3.15
> nix-shell -I nixpkgs=https://github.com/nokx5/nokxpkgs/archive/main.tar.gz -p golden-smalltalk --command cli_golden
> ```

You can use the software with the following commands.
```bash
nix shell github:nokx5/golden-smalltalk --command cli_golden
nix shell github:nokx5/nokxpkgs#golden-smalltalk --command cli_golden
```

## Develop the software with explicit channel (depreciated - new hash)

> Please note that all commands of this section creates new hashes depending on the channel which means that the evaluation may require additional downloads.

Start by cloning the [git repository](https://github.com/nokx5/golden-smalltalk) locally and enter it.

#### Option 1: Develop the software (minimal requirements)

You can develop or build the local software easily with the minimal requirements.

```bash
# option a: develop with a local shell (depreciated - new hash)
nix-shell --expr 'with import <nixpkgs> {}; callPackage ./derivation.nix {src = ./.; }'

# option b: build the local project (depreciated - new hash)
nix-build --expr 'with import <nixpkgs> {}; callPackage ./derivation.nix {src = ./.; }' --no-out-link
```

Note that you can write the nix expression directly to the `default.nix` file to avoid typing `--expr` each time.

#### Option 2: Develop the software (supercharged :artificial_satellite:)

You can enter the supercharged environment for development.

```bash
nix-shell shell.nix # (depreciated - new hash)
```

## Develop the software

> **NOTE:** This section requires the experimental `flake` and `nix-command` features. Please refer to the official documentation for nix flakes. The advantage of using nix flakes is that you avoid channel pinning issues.
> 
> After Nix was installed, update to the unstable feature with:
> 
> ```bash
> nix-env -f '<nixpkgs>' -iA nixUnstable
> ```
> 
> And enable experimental features with:
> 
> ```bash
> mkdir -p ~/.config/nix
> echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
> ```

Start by cloning the [git repository](https://github.com/nokx5/golden-smalltalk) locally and enter it.

#### Option 1: Develop the software

```bash
# option a: develop with a local shell
nix develop .#golden-smalltalk
# or
nix-shell . -A packages.x86_64-linux.golden-smalltalk

# option b: build the local project
nix build .#golden-smalltalk
# or
nix-build . -A packages.x86_64-linux.golden-smalltalk
```

#### Option 2: Develop the software (supercharged :artificial_satellite:)

You can enter the supercharged development environment.

```bash
nix develop
# or
nix-shell . -A devShell.x86_64-linux
```

## Code Snippets

Save the derivations so it does not get garbage collected.
```bash
nix-build . -A packages.x86_64-linux.golden-smalltalk --out-link result-golden-smalltalk
nix-build . -A packages.x86_64-linux.golden-smalltalk.inputDerivation --out-link result-golden-smalltalk-dev
nix-build . -A devShell.x86_64-linux.inputDerivation --out-link result-golden-smalltalk-dev-full

nix-build . -A packages.x86_64-linux.golden-smalltalk-clang --out-link result-golden-smalltalk-clang
nix-build . -A packages.x86_64-linux.golden-smalltalk-clang.inputDerivation --out-link result-golden-smalltalk-clang-dev
```

One line code formatter for C/C++ projects

```bash
nixpkgs-fmt .

```
