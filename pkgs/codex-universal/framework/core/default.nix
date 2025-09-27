{ pkgs, ... }:
let
  inherit (pkgs) lib;
  cores = [
    ./FLAGS.md
    ./RULES.md
    ./PRINCIPLES.md
  ];
in
lib.strings.concatLines (lib.lists.forEach cores (core: builtins.readFile core))
