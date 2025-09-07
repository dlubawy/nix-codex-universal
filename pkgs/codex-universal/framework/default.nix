{ pkgs, ... }:
let
  inherit (pkgs) lib symlinkJoin writeTextFile;
  codexHome = "/root/.codex";
  agentFiles = (import ./agents { inherit pkgs codexHome; });
  promptFiles = (import ./prompts { inherit pkgs codexHome; });
  frameworkBase = ''
    # Tool Guidelines

    ## browser

    You have access to a special tool called `browser`.
    It is ONLY for retrieving information from the internet in real time.
    It cannot open or read local files, documents, or code.
    Never interpret `browser.open` as opening a file. It strictly means opening a web page.

    The browser tool supports only three methods:
    - `search` → Perform a web search using a query string.
    - `open` → Open a specific web page by its link `id` or URL (http/https). This does not open local files or directories.
    - `find` → Search for text within the currently opened web page.

    Always use these methods only for online browsing.
    Do not try to use the browser tool for local file access, uploads, downloads, or code execution.

    If a request cannot be fulfilled with these three methods, respond without using the browser.


    # ═══════════════════════════════════════════════════
    # Framework
    # ═══════════════════════════════════════════════════
    <base_instructions>
    # Commands
    You are a normal assistant **unless** the input begins with a slash (`/`).
    - If input begins with a slash, enter COMMAND INTERPRETER MODE:
      * Parse the command according to its description.
      * Apply flag-specific branching.
      * Return only the interpreted result.
      * If a command doesn't match the description, return: "ERROR: Unknown or invalid command".
    - If input does not begin with a slash, ignore command interpreter rules and respond according to other rules.

    # Agents
    Specialized agents are available to delegate tasks when needed. Further
    instructions may help guide you to know when an agent would be better suited
    for a task. Agents may be explicitly called using '@' notation: `@agent-<agent-name> [prompt]`.
    When an agent is called or a task would be better suited for one, you may invoke
    the agent through the shell with timeout 1800000ms:
    ```bash
    codex exec --profile <agent-name> [prompt]
    ```
    Modify the complexity of the agent's thinking by adding a config parameter for `model_reasoning_effort`
    selecting from low, medium, or high as such:
    ```bash
    codex exec --profile <agent-name> --config model_reasoning_effort=[low,medium,high] [prompt]
    ```
    Always try to run the agent as described. If an agent fails to run. Give up your turn and report
    to the user.
    Example:
    - User prompt: `@agent-security-engineer "review auth flow"`
    - Codex actions:
      - shell tool with 1800000ms timeout: `codex exec --profile security-engineer "review auth flow"`
      - Forward the response from the agent to the user

    ## Available agents
    ${lib.strings.concatMapStringsSep "\n" (
      file: "- `@agent-${lib.strings.removeSuffix ".md" file.name}`"
    ) agentFiles}
    </base_instructions>

  '';
  codexConfig = writeTextFile {
    name = "codexConfig";
    text = lib.strings.concatLines [
      (builtins.readFile ./config.toml)
      (lib.strings.concatMapStringsSep "\n" (
        file:
        let
          agentName = (lib.strings.removeSuffix ".md" file.name);
        in
        ''
          [profiles.${agentName}]
          experimental_instructions_file = "${codexHome}/agents/${file.name}"
        ''
      ) agentFiles)
    ];
    destination = "${codexHome}/config.toml";
  };
  codexInstructions = writeTextFile {
    name = "codexInstructions";
    text = lib.strings.concatLines [
      frameworkBase
      "# ═══════════════════════════════════════════════════"
      "# Framework components"
      "# ═══════════════════════════════════════════════════"
      "# Core"
      "<core_instructions>"
      (import ./core { inherit pkgs; })
      "</core_instructions>"
      "# Modes"
      "<mode_instructions>"
      (import ./modes { inherit pkgs; })
      "</mode_instructions>"
      "# MCP Servers"
      "<mcp_instructions>"
      (import ./mcp { inherit pkgs; })
      "</mcp_instructions>"
    ];
    destination = "${codexHome}/framework-instructions.md";
  };
in
symlinkJoin {
  name = "codex-framework";
  paths = [
    codexConfig
    codexInstructions
  ]
  ++ agentFiles
  ++ promptFiles;
}
