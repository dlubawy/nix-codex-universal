{ pkgs, codexHome, ... }:
let
  inherit (pkgs) lib writeTextFile;
  prompts = [
    ./analyze.md
    ./brainstorm.md
    ./build.md
    ./business-panel.md
    ./cleanup.md
    ./design.md
    ./document.md
    ./estimate.md
    ./explain.md
    ./git.md
    ./help.md
    ./implement.md
    ./improve.md
    ./index.md
    ./load.md
    ./reflect.md
    ./save.md
    ./select-tool.md
    ./spawn.md
    ./task.md
    ./test.md
    ./troubleshoot.md
    ./workflow.md
  ];
in
(lib.lists.concatMap (prompt: [
  (writeTextFile rec {
    name = builtins.baseNameOf prompt;
    text = builtins.readFile prompt;
    destination = "${codexHome}/prompts/${name}";
  })
]) prompts)
