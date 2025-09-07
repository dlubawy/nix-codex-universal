# Contributing to Nix Codex Universal

Thank you for your interest in contributing to Codex Universal! This guide will walk you through the process of setting up your development environment, submitting changes, and ensuring that your contributions meet our quality standards.

## Table of Contents

1. [Getting Started](#getting-started)
1. [Development Workflow](#development-workflow)
1. [Coding Standards](#coding-standards)
1. [Testing](#testing)
1. [Submitting a Pull Request](#submitting-a-pull-request)
1. [Code of Conduct](#code-of-conduct)

## Getting Started

### Prerequisites

- **Git** – Version control system.
- **Python 3.10+** – The core CLI is written in Python.
- **Node.js 20+** – Required for the UI component generator and some MCP servers.
- **Docker** – Optional but recommended for running the full stack locally.

### Clone the Repository

```bash
git clone https://github.com/your-org/codex-universal.git
cd codex-universal
```

### Setup Nix development shell

```bash
nix develop .
# or if direnv installed
direnv allow
```

## Development Workflow

1. **Create a feature branch** from `main`.
   ```bash
   git checkout -b feature/your-feature-name
   ```
1. **Make your changes**. Follow the coding standards below.
1. **Run tests** to ensure nothing is broken.
1. **Commit** with a clear, concise message.
1. **Push** the branch to GitHub.
1. **Open a Pull Request** against `main`.

## Coding Standards

- Keep functions small and focused. Aim for a single responsibility.
- Add docstrings/comments where the intent is not obvious.
- Avoid breaking changes unless absolutely necessary. If you must, document the migration path.

## Testing

```bash
nix check --all-systems .
```

All tests should pass locally before submitting a PR.

## Submitting a Pull Request

1. Ensure your branch is up to date with `main`.
1. Run `git rebase main` or `git merge main` to incorporate the latest changes.
1. Verify that all tests and pre-commit pass.
1. Push the branch and open a PR.
1. Provide a clear title and description. Reference any related issues.
1. Request a review from a project maintainer.

## Code of Conduct

We follow the [Contributor Covenant](https://www.contributor-covenant.org/) 2.0. Please read it before contributing.

______________________________________________________________________

If you have any questions, feel free to open an issue or reach out to the maintainers.
