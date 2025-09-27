{ pkgs, codexHome, ... }:
let
  inherit (pkgs) lib writeTextFile;
  prompts = [
    ./sc-analyze.md
    ./sc-brainstorm.md
    ./sc-build.md
    ./sc-business-panel.md
    ./sc-cleanup.md
    ./sc-design.md
    ./sc-document.md
    ./sc-estimate.md
    ./sc-explain.md
    ./sc-git.md
    ./sc-help.md
    ./sc-implement.md
    ./sc-improve.md
    ./sc-index.md
    ./sc-load.md
    ./sc-reflect.md
    ./sc-research.md
    ./sc-save.md
    ./sc-select-tool.md
    ./sc-spawn.md
    ./sc-task.md
    ./sc-test.md
    ./sc-troubleshoot.md
    ./sc-workflow.md
  ];
in
(lib.lists.concatMap (prompt: [
  (writeTextFile rec {
    name = builtins.baseNameOf prompt;
    text = builtins.readFile prompt;
    destination = "${codexHome}/prompts/${name}";
  })
]) prompts)
