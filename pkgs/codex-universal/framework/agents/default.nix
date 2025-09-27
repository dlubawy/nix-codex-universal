{ pkgs, codexHome, ... }:
let
  inherit (pkgs) lib writeTextFile;
  agents = [
    ./backend-architect.md
    ./business-panel-experts.md
    ./deep-research-agent.md
    ./devops-architect.md
    ./frontend-architect.md
    ./learning-guide.md
    ./performance-engineer.md
    ./python-expert.md
    ./quality-engineer.md
    ./refactoring-expert.md
    ./requirements-analyst.md
    ./root-cause-analyst.md
    ./security-engineer.md
    ./socratic-mentor.md
    ./system-architect.md
    ./technical-writer.md
  ];
in
(lib.lists.concatMap (agent: [
  (writeTextFile rec {
    name = builtins.baseNameOf agent;
    text = builtins.readFile agent;
    destination = "${codexHome}/agents/${name}";
  })
]) agents)
