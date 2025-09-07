# Repository Guidelines

This guide provides a quick reference for contributors working on the
Codex Universal repository. It covers the layout of the codebase,
build/test commands, coding style, and PR etiquette.

## Project Structure & Module Organization

The repository follows a Nix‑based layout. The source lives under `pkgs/`.

## Build, Test, and Development Commands

The project uses Nix for reproducible builds. Common tasks are:

```bash
# Build the Nix package
nix build .

# Run the CLI locally
./result/bin/codex-start --help

# Run unit tests
nix flake check --all-systems .
```

## Coding Style & Naming Conventions

Run `nix flake check .` to check style.

## Testing Guidelines

To run all tests:

```bash
nix flake check --all-systems .
```

## Commit & Pull Request Guidelines

- **Commit messages** – Conventional Commits style (`feat:`, `fix:`, `docs:`).
- **PR description** – Summarise the change, link any issue, and include
  screenshots if UI is affected.
- **Review** – At least one maintainer must approve.
- **CI** – All checks must pass before merging.

Example PR title: `feat: add new agent for performance analysis`.
