# Nix Codex Universal

Nix Codex Universal is a modular, extensible framework designed to streamline
software development workflows. It bundles a collection of command‑line
utilities, a powerful business‑panel analysis engine, and a set of
high‑level agents that can be invoked from the terminal.

## Features

- **Command Library** – A set of `/sc:<command>` utilities that cover
  everything from code analysis (`/sc:analyze`) to design
  (`/sc:design`) and testing (`/sc:test`).
- **Business‑Panel** – A multi‑expert business analysis mode that
  brings together thought leaders such as Porter, Christensen, and
  Meadows to provide strategic insights.
- **MCP Servers** – Dedicated servers for context‑aware documentation
  lookup, UI component generation, bulk code transformations, and
  browser automation.
- **Agent System** – Lightweight agents (e.g. `@agent-python-expert`) that
  can be invoked for specialized tasks.
- **Token‑Efficient Mode** – Symbol‑based communication that reduces
  token usage by 30‑50 % while preserving clarity.

## Getting Started

### Prerequisites

- Nix

### Installation

```bash
git clone https://github.com/your-org/codex-universal.git
cd codex-universal
nix shell .
```

### Running the CLI

```bash
# List available commands
codex-start --help

# Example: Analyze a source directory
codex-start "/sc:analyze src/ --think"

# Example: Run a business panel on a strategy document
codex-start "/sc:business-panel @strategy_doc.pdf"
```

## Project Structure

The repository follows a Nix‑based layout. The top‑level `pkgs` directory
contains the Nix expressions that build the Codex Universal package. The
actual source lives under `pkgs/codex-universal/framework` and is
organised into several sub‑directories:

```
nix-codex-universal/
├── pkgs/
│   └── codex-universal/
│       ├── framework/
│       │   ├── agents/          # Agent definitions (Markdown)
│       │   ├── commands/        # /sc command definitions (Markdown)
│       │   ├── config.toml      # Global configuration
│       │   ├── core/            # Core framework files (rules, flags, etc.)
│       │   ├── mcp/             # MCP server definitions
│       │   └── modes/           # Mode definitions (Brainstorming, Business‑Panel, etc.)
│       ├── Caddyfile            # Web server config
│       ├── codex-universal.nix  # Main definition of scripts to start/use codex
│       └── default.nix          # Exposes codex-universal as a unified package
├── flake.lock
├── flake.nix
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

The `framework` directory contains the core logic for the CLI, the
business‑panel engine, and the MCP server implementations. The
`agents` and `commands` sub‑directories hold the Markdown files that
specify the behaviour of each agent and command.

## Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md)
for guidelines on how to submit pull requests, run tests, and
maintain code quality.

## License

This project is licensed under the MIT License – see the
[LICENSE](LICENSE) file for details.

______________________________________________________________________

For more information, see the [documentation](docs/).
